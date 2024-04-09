import 'package:flutter/material.dart';

class TreePainting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Painter Example'),
        ),
        body: CustomPaint(
          painter: LinePainter(),
          child: Container(
            child: ListView(
              children: <Widget>[
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
                ListTile(title: Text('Item 3')),
                // Add more list tiles as needed
                ListTile(title: Text('Item 4')),
                ListTile(title: Text('Item 5')),
                ListTile(title: Text('Item 6')),
                // Add more list tiles as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final double startY = 0.0;
    final double endY = size.height;

    final double startX = size.width / 2; // Position the line between pages

    final double dashWidth = 5.0;
    final double dashSpace = 5.0;
    bool paintDash = false;
    double currentY = startY;

    while (currentY < endY) {
      if (paintDash) {
        canvas.drawLine(Offset(startX, currentY),
            Offset(startX, currentY + dashWidth), linePaint);
      }
      currentY += dashWidth + dashSpace;
      paintDash = !paintDash;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
