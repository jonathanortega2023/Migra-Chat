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
        body: CustomPaint(
          painter: TreePainter(),
          child: Container(),
        ));
  }
}

class TreePainter extends CustomPainter {
  // skeleton listtile for tree, has leading icon and title or trailing icon
  Widget _skeletonListTile(
      {required IconData icon, String? title, bool hasLeadingIcon = true}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title ?? ''),
      trailing: trailingIcon != null ? Icon(trailingIcon) : null,
    );
  }
}
