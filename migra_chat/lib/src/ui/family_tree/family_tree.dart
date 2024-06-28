import 'package:flutter/material.dart';
import 'package:migra_chat/src/models/person.dart';
import './widgets.dart';

final List<Person> people = [
  Person(
    isPrimary: true,
    firstName: 'Bart',
    lastName: 'Simpson',
    livingStatus: LivingStatus.alive,
    maritalStatus: MaritalStatus.single,
    dateOfBirth: DateTime(1980, 2, 23),
    gender: Gender.male,
    relationships: {},
    usCitizenStatus: USCitizenship.citizen,
  )
];

class FamilyTreePage extends StatelessWidget {
  const FamilyTreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
