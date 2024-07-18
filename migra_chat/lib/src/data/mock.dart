import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migra_chat/src/models/person.dart';

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

Person herb = Person(
  isPrimary: false,
  firstName: 'Herb',
  lastName: 'Powell',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.single,
  dateOfBirth: DateTime(1956, 10, 16),
  relationships: {},
  usCitizenStatus: USCitizenship.citizen,
);

// List<Person> allPeople = [
//   homer,
//   marge,
//   bart,
//   lisa,
//   maggie,
//   abe,
//   mona,
//   patty,
//   selma,
//   jacqueline
// ];

// read from people.json
List<Person> allPeople = [];

List<Person> getPeople() {
  homer.addSpouse(marge);
  homer.addChildren([bart, lisa, maggie], spouse: marge);
  abe.addSpouse(mona);
  abe.addChild(homer, spouse: mona);
  abe.addChild(herb);
  jacqueline.addChildren([patty, selma, marge]);
  allPeople = [
    homer,
    marge,
    bart,
    lisa,
    maggie,
    abe,
    mona,
    herb,
    patty,
    selma,
    jacqueline
  ];
  return allPeople;
}

Person getPerson(String uid) {
  return allPeople.firstWhere((element) => element.uid == uid);
}

Person getPrimaryPerson() {
  return allPeople.firstWhere((element) => element.isPrimary);
}

Map<String, Person> getPeopleMap() {
  Map<String, Person> peopleMap = {};
  for (Person person in allPeople) {
    peopleMap[person.uid] = person;
  }
  return peopleMap;
}

// void main() async {
//   homer.addSpouse(marge);
//   homer.addChildren([bart, lisa, maggie], spouse: marge);
//   abe.addSpouse(mona);
//   abe.addChild(homer, spouse: mona);
//   jacqueline.addChildren([patty, selma, marge]);
// }
