import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final List<Person>? children;
  final Person? spouse;

  Person({required this.name, this.children, this.spouse});
}

final List<Person> people = [
  Person(name: 'Roger Pate', children: [
    Person(name: 'Ryan Pate'),
    Person(name: 'Larissa Pate'),
  ]),
  Person(name: 'Karen Pate', children: [
    Person(name: 'Ryan Pate'),
    Person(name: 'Mike Something'),
    Person(name: 'Chelsea Holdemann', children: [
      Person(name: 'Tessa Holdemann'),
    ])
  ]),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Tree',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FamilyTreePage(),
    );
  }
}

class FamilyTreePage extends StatelessWidget {
  final List<Person> familyMembers = [
    Person(name: 'Roger Pate', children: [
      Person(name: 'Ryan Pate'),
      Person(name: 'Larissa Pate'),
    ]),
    Person(name: 'Karen Pate', children: [
      Person(name: 'Ryan Pate'),
      Person(name: 'Mike Something'),
      Person(name: 'Chelsea Holdemann', children: [
        Person(name: 'Tessa Holdemann'),
      ])
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Tree'),
      ),
      body: PageView.builder(
        itemCount: familyMembers.length,
        itemBuilder: (context, index) {
          return FamilyMemberTile(familyMember: familyMembers[index]);
        },
      ),
    );
  }
}

class FamilyMemberTile extends StatelessWidget {
  final Person familyMember;

  FamilyMemberTile({required this.familyMember});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TreePainter(familyMember: familyMember),
      child: Container(
        width: 300.0,
        height: 300.0,
        color: Colors.white,
        child: Center(
          child: Text(familyMember.name),
        ),
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  final Person familyMember;

  TreePainter({required this.familyMember});

  @override
  void paint(Canvas canvas, Size size) {}

  void paintText(Canvas canvas, Offset offset, String text) {
    final textStyle = TextStyle(color: Colors.black, fontSize: 16.0);
    final TextSpan span = TextSpan(style: textStyle, text: text);
    final textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
