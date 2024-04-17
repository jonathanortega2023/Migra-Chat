import 'package:flutter/material.dart';
import 'package:migra_chat/src/ui/widgets.dart';

class TreePageMockup extends StatelessWidget {
  const TreePageMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Tree'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          children: [
            const Text('Family Tree Mockup'),
            const Text('Coming soon...'),
          ],
        ),
      ),
    );
  }
}
