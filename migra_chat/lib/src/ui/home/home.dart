import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Expanded(
      child: Column(
        children: [
          UserInfoTile(),
          CitizenshipStatusBar(),
          FormsBreakdown(),
          KeepReadingButton()
        ],
      ),
    ));
  }
}

// ListTile with leading icon/age and Name/Residence
class UserInfoTile extends StatelessWidget {
  const UserInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CitizenshipStatusBar extends StatelessWidget {
  const CitizenshipStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// Row with 3 sections, each with a title and a number (links to forms page). TODO | Pending | Processed
class FormsBreakdown extends StatelessWidget {
  const FormsBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// Button that links to the most recently read content
class KeepReadingButton extends StatelessWidget {
  const KeepReadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
