import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return GFIntroScreen(
      pageCount: 3,
      currentIndex: 0,
      pageController: pageController,
      slides: <Widget>[
        Container(
          color: Colors.red,
          child: const Center(
            child: Text(
              'Slide 1',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.green,
          child: const Center(
            child: Text(
              'Slide 2',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Slide 3',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
