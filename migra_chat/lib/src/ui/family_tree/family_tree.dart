import 'package:flutter/material.dart';
import '../../models/person.dart';
import 'package:getwidget/getwidget.dart';

// ignore: non_constant_identifier_names
final Person ME = PrimaryPerson(
  firstName: "John",
  middleName: "Doe",
  lastName: "Smith",
  gender: Gender.male,
  usCitizenStatus: USCitizenship.citizen,
  countryOfResidence: Country.us,
  usZipCode: 60647,
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.married,
  dateOfBirth: DateTime(1998, 5, 29),
  relationships: {},
);

class FamilyTree extends StatefulWidget {
  const FamilyTree({super.key});

  @override
  State<FamilyTree> createState() => _FamilyTreeState();
}

class _FamilyTreeState extends State<FamilyTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: PageView.builder(
          itemBuilder: (context, index) {
            return Center(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0){
                    // Add person button
                    return ListTile(
                      title: Center(child: Text('Add Sibling')),
                      onTap: () {
                        // Implement your onTap logic here
                      },
                    );
                  }
                  return FamilyTreeLeaf(person: ME);
                  return ListTile(
                    title: Center(child: Text('Person $index')),
                  );
                },
                shrinkWrap: true,
                itemCount: 5,
              ),
            );
          },
          controller: PageController(viewportFraction: 0.8),
        ));
  }
}

class FamilyTreeLeaf extends StatelessWidget {
  final Person person;

  const FamilyTreeLeaf({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      color: Colors.blue,
      radius: 50,
      avatar: GFAvatar(
        // Example: Displaying initials as avatar
        child: Text(
          '${person.firstName[0]}${person.lastName[0]}',
          style: TextStyle(fontSize: 20),
        ),
      ),
      title: Text('${person.fullName}'),
      subTitle: Text('Age: ${person.age}'),
      // You can customize ListTile's onTap behavior here
      onTap: () {
        // Implement your onTap logic here
      },
    );
  }
}
