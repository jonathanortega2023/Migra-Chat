import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late PageController _pageController;
  late List<Widget> slideList = slides();
  late int initialPage;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GFIntroScreen(
        color: Colors.blueGrey,
        slides: slides(),
        pageController: _pageController,
        currentIndex: initialPage,
        pageCount: 5,
        introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
          pageController: _pageController,
          pageCount: slideList.length,
          currentIndex: initialPage,
          onForwardButtonTap: () {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          },
          onBackButtonTap: () {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          },
          navigationBarColor: Colors.white,
          showDivider: false,
          inactiveColor: Colors.grey[200]!,
          activeColor: GFColors.SUCCESS,
        ),
      ),
    );
  }

  List<Widget> slides() {
    slideList = [
      const WelcomeSlide(),
      const IntroSlide(),
      const TreeSlide(),
      const QuerySlide(),
      const ClosingSlide(),
    ];
    return slideList;
  }
}

class ClosingSlide extends StatelessWidget {
  const ClosingSlide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Privacy and data security are top concern, so:',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text(
                '•No data is shared or stored online',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                '•AI models are run locally on your device',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                '•Files are encrypted so they cannot be copied or taken',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuerySlide extends StatelessWidget {
  const QuerySlide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue, Colors.green],
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/flutter_logo.png',
          fit: BoxFit.contain,
        ),
      ),
    ));
  }
}

class TreeSlide extends StatelessWidget {
  const TreeSlide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.green],
        ),
      ),
      child: Column(children: [
        const Flexible(
          flex: 3,
          child: Text(
            'You start by creating your family tree, the connections and background information provided will serve as context for the chat bot.',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        Flexible(
            flex: 7,
            child: Center(
              child: Image.asset(
                'assets/images/flutter_logo.png',
                fit: BoxFit.contain,
              ),
            )),
      ]),
    ));
  }
}

class IntroSlide extends StatelessWidget {
  const IntroSlide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue, Colors.green],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Navigating US immigration law and finding resources can be costly, time-consuming, and confusing.',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'MigraChat serves to make information accessible and personalized to your family\'s situation',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class WelcomeSlide extends StatelessWidget {
  const WelcomeSlide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME TO',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'MigraChat',
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'YOUR FAMILY\'S TOOL FOR AN EASIER FUTURE.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
