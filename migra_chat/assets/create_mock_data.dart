import '/workspaces/MigraChat/migra_chat/lib/src/models/person.dart';
import 'dart:io';
import 'dart:convert';

Person rogerPate = Person(
    isPrimary: false,
    firstName: "Roger",
    lastName: "Pate",
    livingStatus: LivingStatus.alive,
    maritalStatus: MaritalStatus.married,
    dateOfBirth: DateTime(1960),
    gender: Gender.male,
    usCitizenStatus: USCitizenship.citizen,
    relationships: <String, Relationship>{});

Person karenPate = Person(
    isPrimary: false,
    firstName: "Karen",
    lastName: "Pate",
    livingStatus: LivingStatus.alive,
    maritalStatus: MaritalStatus.married,
    dateOfBirth: DateTime(1965),
    gender: Gender.female,
    usCitizenStatus: USCitizenship.citizen,
    relationships: <String, Relationship>{
      rogerPate.uid: Relationship.spouse,
    });

Person ryanPate = Person(
  isPrimary: false,
  firstName: "Ryan",
  lastName: "Pate",
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(2000),
  gender: Gender.female,
  usCitizenStatus: USCitizenship.citizen,
  relationships: <String, Relationship>{
    rogerPate.uid: Relationship.parent,
    karenPate.uid: Relationship.parent,
  },
);

Person jonOrtega = Person(
    isPrimary: true,
    firstName: "Jon",
    lastName: "Ortega",
    livingStatus: LivingStatus.alive,
    maritalStatus: MaritalStatus.single,
    dateOfBirth: DateTime(2000),
    gender: Gender.male,
    usCitizenStatus: USCitizenship.citizen,
    relationships: <String, Relationship>{});

Person alexaOrtega = Person(
  isPrimary: false,
  firstName: "Alexa",
  lastName: "Ortega",
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(2005),
  gender: Gender.female,
  usCitizenStatus: USCitizenship.citizen,
  relationships: <String, Relationship>{},
);

Person alyshaOrtega = Person(
  isPrimary: false,
  firstName: "Alysha",
  lastName: "Ortega",
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(2005),
  gender: Gender.female,
  usCitizenStatus: USCitizenship.citizen,
  relationships: <String, Relationship>{},
);

Person aaliyahOrtega = Person(
  isPrimary: false,
  firstName: "Aaliyah",
  lastName: "Ortega",
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(2010),
  gender: Gender.female,
  usCitizenStatus: USCitizenship.citizen,
  relationships: <String, Relationship>{},
);

Person ramonOrtega = Person(
  isPrimary: false,
  firstName: "Ramon",
  lastName: "Ortega",
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(1970),
  gender: Gender.male,
  usCitizenStatus: USCitizenship.citizen,
  relationships: <String, Relationship>{
    jonOrtega.uid: Relationship.child,
    alyshaOrtega.uid: Relationship.child,
    aaliyahOrtega.uid: Relationship.child,
    alexaOrtega.uid: Relationship.child,
  },
);

Person luisaOrtega = Person(
  isPrimary: false,
  firstName: "Luisa",
  lastName: "Ortega",
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(1975),
  gender: Gender.female,
  usCitizenStatus: USCitizenship.citizen,
  relationships: <String, Relationship>{
    jonOrtega.uid: Relationship.child,
    alyshaOrtega.uid: Relationship.child,
    aaliyahOrtega.uid: Relationship.child,
    alexaOrtega.uid: Relationship.child,
    ramonOrtega.uid: Relationship.spouse,
  },
);

void main() {
  rogerPate.relationships[karenPate.uid] = Relationship.spouse;
  // save all users to 'mock_data.json'
  writeToJSON('mock_data.json', 'mock_data.json', {
    'users': [
      rogerPate.toJson(),
      karenPate.toJson(),
      ryanPate.toJson(),
      jonOrtega.toJson(),
      alexaOrtega.toJson(),
      alyshaOrtega.toJson(),
      aaliyahOrtega.toJson(),
      ramonOrtega.toJson(),
      luisaOrtega.toJson(),
    ]
  });
}

void writeToJSON(String sourcePath, String destinationPath,
    Map<String, List<Map<String, dynamic>>> map) {
  // Convert the data to JSON format
  String jsonData = json.encode(map);

  // Write the JSON data to the destination file
  File(destinationPath).writeAsStringSync(jsonData);

  print('Data saved to $destinationPath');
}
