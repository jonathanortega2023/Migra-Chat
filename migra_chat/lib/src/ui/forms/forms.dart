import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({super.key});

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
          child: Column(
        children: [
          // TabBar for TODO | Pending | Processed
          // Accordion for category of document
          GFAccordion(
            title: 'Citizenship/Naturalization',
            contentChild: ListView(children: [
              GFAccordion(
                title: 'I-942, Request for Reduced Fee',
                contentChild: Column(
                  children: [
                    // richtext with links
                    // buttons for learn more link to uscis and start form
                  ],
                ),
              )
            ]),
          )
        ],
      )),
    );
  }
}
