import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

// drawer widget with routes to other pages
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
        child: ListView(
      children: [
        GFListTile(
          title: const Text('Intake'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/intake');
          },
        ),
        GFListTile(
          title: const Text('Family Tree'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/family_tree');
          },
        ),
        GFListTile(
          title: const Text('Tree Testing'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/test_tree');
          },
        ),
        GFListTile(
          title: const Text('Landing Page'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/landing');
          },
        ),
        GFListTile(
          title: const Text('Tree Painting'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/painting');
          },
        ),
        GFListTile(
          title: const Text('Chat'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/chat');
          },
        ),
      ],
    ));
  }
}
