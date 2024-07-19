// Importing necessary packages
import 'dart:io';

import 'package:migra_chat/src/data/mock.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_community/langchain_community.dart';
import 'package:langchain_ollama/langchain_ollama.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:migra_chat/src/models/person.dart';
import 'package:objectbox/objectbox.dart';
import 'package:objectbox/internal.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

// Defining the bot user
const types.User botUser = types.User(
  id: '0',
  // TODO Add bot avatar
  // imageUrl:
);

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  List<Person> allPeople = getPeople();
  late final types.User _user;
  late final ObjectBoxVectorStore vectorStore;
  late final Embeddings embeddings;
  late final Retriever retriever;
  late final Runnable chain;
  late final ChatOllama chatModel;
  late final ChatPromptTemplate promptTemplate;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final primaryPerson = allPeople.firstWhere((person) => person.isPrimary);
    _user = types.User(
      id: primaryPerson.uid,
      firstName: primaryPerson.firstName,
      lastName: primaryPerson.lastName,
    );
    _initializeChatComponents();
    _loadMessages();
  }

  Future<void> _initializeChatComponents() async {
    // Search and create db file destination folder if not exist
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final objectBoxDirectory =
        Directory('${documentsDirectory.path}/objectbox/');

    if (!objectBoxDirectory.existsSync()) {
      await objectBoxDirectory.create(recursive: true);
    }

    final dbFile = File('${objectBoxDirectory.path}/data.mdb');
    if (!dbFile.existsSync()) {
      // Get pre-populated db file.
      ByteData data = await rootBundle
          .load("assets/resources/Federal/Legislation/objectbox/data.mdb");
      // Copying source data into destination file.
      await dbFile.writeAsBytes(data.buffer.asUint8List());
    }

    // Initialize ObjectBoxVectorStore
    embeddings = OllamaEmbeddings(model: 'mxbai-embed-large');
    vectorStore = ObjectBoxVectorStore(
      embeddings: embeddings,
      dimensions: 1024,
      directory: objectBoxDirectory.path,
    );
    chatModel = ChatOllama(
      defaultOptions: const ChatOllamaOptions(model: 'llama3:8b'),
    );

    promptTemplate = ChatPromptTemplate.fromTemplate('''
Answer the question based only on the following context:
{context}
Question: {question}''');

    chain = Runnable.fromMap<String>({
          'context': retriever | Runnable.mapInput((docs) => docs.join('\n')),
          'question': Runnable.passthrough(),
        }) |
        promptTemplate |
        chatModel |
        const StringOutputParser();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handlePreviewDataFetched(
      types.TextMessage message, types.PreviewData previewData) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    if (message.text.trim().isEmpty) {
      return;
    }
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
    // Generate response from langchain model
    final response = await chain.invoke(message.text);
    _addMessage(types.TextMessage(
      author: botUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: '0',
      text: response as String,
    ));
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

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          inputOptions: InputOptions(
            onTextChanged: (text) {
              setState(() {
                textController.text = text;
              });
            },
            textEditingController: textController,
          ),
          messages: _messages,
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
