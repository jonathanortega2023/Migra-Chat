import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UserIntake extends StatefulWidget {
  const UserIntake({super.key});

  @override
  State<UserIntake> createState() => _UserIntakeState();
}

class _UserIntakeState extends State<UserIntake> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
          key: _formKey,
          child: Column(children: <Widget>[
            FormBuilderChoiceChip(
              name: "choice chip",
              options: [
                FormBuilderChipOption(
                  value: "Test",
                  child: Text("Test"),
                ),
                FormBuilderChipOption(
                  value: "Test 1",
                  child: Text("Test 1"),
                ),
                FormBuilderChipOption(
                  value: "Test 2",
                  child: Text("Test 2"),
                ),
              ],
            ),
            FormBuilderFilterChip(name: "filter chip", options: [
              FormBuilderChipOption(
                value: "Test",
                child: Text("Test"),
              ),
              FormBuilderChipOption(
                value: "Test 1",
                child: Text("Test 1"),
              ),
            ]),
            FormBuilderRadioGroup(
              name: "Radio group",
              options: [
                "Test",
                "Test 1",
                "Test 2",
              ].map((e) => FormBuilderFieldOption(value: e)).toList(),
            ),
          ])),
    );
  }
}
