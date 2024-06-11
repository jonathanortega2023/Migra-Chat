import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    // Check if the message contains non-whitespace characters
    if (message.text.trim().isNotEmpty) {
      final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message.text,
      );

      _addMessage(textMessage);
    }
  }

  void _loadMessages() async {
    // Load default messages
    final messages = [
      types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'Hello!',
      ),
      types.TextMessage(
        author: const types.User(id: 'other_user_id'),
        createdAt: DateTime.now()
            .add(const Duration(minutes: -5))
            .millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'Hi there!',
      ),
    ];

    setState(() {
      _messages = messages;
    });
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          // hack to make the send button work on 3rd party keyboards
          inputOptions: InputOptions(
            onTextChanged: (text) {
              setState(() {
                textController.text = text;
              });
            },
            textEditingController: textController,
          ),

          messages: _messages,
          // onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          usePreviewData: true,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
          theme: const DefaultChatTheme(
            seenIcon: Text(
              'read',
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
          ),
        ),
      );
}
