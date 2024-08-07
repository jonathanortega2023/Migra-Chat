import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

Widget drawerList(context) {
  return ListView(
    children: [
      GFListTile(
        title: const Text('Home'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/home');
        },
      ),
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
        title: const Text('Landing Page'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/landing');
        },
      ),
      GFListTile(
        title: const Text('Chat'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/chat');
        },
      ),
      GFListTile(
        title: const Text('Forms'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/forms');
        },
      ),
      GFListTile(
        title: const Text('PDF Edit'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/pdf_edit');
        },
      ),
    ],
  );
}

// drawer widget with routes to other pages
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GFDrawer(child: drawerList(context));
  }
}
