import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:migra_chat/src/models/person.dart';
import 'package:qr_flutter/qr_flutter.dart';

Person homer = Person(
  isPrimary: true,
  firstName: 'Homer',
  lastName: 'Simpson',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.married,
  dateOfBirth: DateTime(1956, 5, 12),
  gender: Gender.male,
  countryOfResidence: Country.us,
  usCitizenStatus: USCitizenship.citizen,
  usZipCode: '12345',
  relationships: {},
);

Person marge = Person(
  isPrimary: false,
  firstName: 'Marge',
  lastName: 'Simpson',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.married,
  dateOfBirth: DateTime(1955, 3, 19),
  gender: Gender.female,
  countryOfResidence: Country.us,
  usCitizenStatus: USCitizenship.citizen,
  usZipCode: '12345',
  relationships: {},
);

Person bart = Person(
  isPrimary: false,
  firstName: 'Bart',
  lastName: 'Simpson',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(1979, 2, 23),
  gender: Gender.male,
  countryOfResidence: Country.us,
  usCitizenStatus: USCitizenship.citizen,
  usZipCode: '12345',
  relationships: {},
);

Person lisa = Person(
  isPrimary: false,
  firstName: 'Lisa',
  lastName: 'Simpson',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(1981, 5, 9),
  gender: Gender.female,
  countryOfResidence: Country.us,
  usCitizenStatus: USCitizenship.citizen,
  usZipCode: '12345',
  relationships: {},
);

Person maggie = Person(
  isPrimary: false,
  firstName: 'Maggie',
  lastName: 'Simpson',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(1988, 1, 14),
  gender: Gender.female,
  countryOfResidence: Country.us,
  usCitizenStatus: USCitizenship.citizen,
  usZipCode: '12345',
  relationships: {},
);

Person abe = Person(
  isPrimary: false,
  firstName: 'Abraham',
  lastName: 'Simpson',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.widowed,
  dateOfBirth: DateTime(1901, 5, 25),
  usCitizenStatus: USCitizenship.citizen,
  relationships: {},
);

Person mona = Person(
  isPrimary: false,
  firstName: 'Mona',
  lastName: 'Simpson',
  livingStatus: LivingStatus.deceased,
  maritalStatus: MaritalStatus.widowed,
  dateOfBirth: DateTime(1923, 3, 15),
  dateOfDeath: DateTime(1995, 8, 10),
  usCitizenStatus: USCitizenship.citizen,
  relationships: {},
);

Person patty = Person(
  isPrimary: false,
  firstName: 'Patty',
  lastName: 'Bouvier',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(1948, 1, 1),
  relationships: {},
  usCitizenStatus: USCitizenship.citizen,
);

Person selma = Person(
  isPrimary: false,
  firstName: 'Selma',
  lastName: 'Bouvier',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(1948, 1, 1),
  relationships: {},
  usCitizenStatus: USCitizenship.citizen,
);

Person jacqueline = Person(
  isPrimary: false,
  firstName: 'Jacqueline',
  lastName: 'Bouvier',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(1929, 1, 1),
  relationships: {},
  usCitizenStatus: USCitizenship.citizen,
);

List<Person> allPeople = [
  homer,
  marge,
  bart,
  lisa,
  maggie,
  abe,
  mona,
  patty,
  selma,
  jacqueline
];
void main() async {
  homer.addSpouse(marge);
  homer.addChildren([bart, lisa, maggie], addToSpouse: true, spouse: marge);
  abe.addSpouse(mona);
  abe.addChild(homer, addToSpouse: true, spouse: mona);
  jacqueline.addChildren([patty, selma, marge]);

  final compressed = gzip.encode(jsonEncode(allPeople).codeUnits);
  final qrCode = QrCode.fromUint8List(
      data: Uint8List.fromList(compressed), errorCorrectLevel: 0);
}
