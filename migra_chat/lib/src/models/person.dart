// on modification, run command: `dart run build_runner build`

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'person.g.dart';

enum Gender { male, female, nonBinary }

enum Country { us, canada, mexico, other }

enum USCitizenship { citizen, resident, visa, undocumented }

enum Relationship {
  parent,
  child,
  sibling,
  stepchild,
  stepSibling,
  stepParent,
  spouse,
  exSpouse
}

enum LivingStatus { alive, deceased }

enum MaritalStatus { single, married, divorced, widowed }

@JsonSerializable()
class Person {
  bool isPrimary;
  String uid;
  String firstName;
  String? middleName;
  String lastName;
  LivingStatus livingStatus;
  MaritalStatus? maritalStatus;
  DateTime dateOfBirth;
  DateTime? dateOfDeath;
  Gender gender;
  Country? countryOfResidence;
  DateTime? dateOfEntry;
  USCitizenship? usCitizenStatus;
  String? usZipCode;
  Map<String, Relationship> relationships;
  Person({
    required this.isPrimary,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.livingStatus,
    required this.maritalStatus,
    required this.dateOfBirth,
    this.dateOfDeath,
    required this.gender,
    this.countryOfResidence,
    required this.usCitizenStatus,
    this.usZipCode,
    required this.relationships,
  })  : assert(firstName.trim().isNotEmpty && lastName.trim().isNotEmpty),
        assert(dateOfBirth.isBefore(DateTime.now()) && dateOfBirth.year > 1900),
        assert(dateOfDeath == null || dateOfDeath.isAfter(dateOfBirth)),
        assert(usZipCode == null || usZipCode.toString().length == 5),
        uid = const Uuid().v4();

  String get fullName => '$firstName ${middleName ?? ''} $lastName';
  bool get isAlive => livingStatus == LivingStatus.alive;
  int get age => DateTime.now().difference(dateOfBirth).inDays ~/ 365;
  int get ageAtDeath => DateTime.now().difference(dateOfDeath!).inDays ~/ 365;
  bool get isAdult => age >= 18;
  bool get isMinor => age < 18;
  bool get isSenior => age >= 65;
  int get numDependents =>
      relationships.values.where((r) => r == Relationship.child).length;
  String? get zipCode => usZipCode;
  bool get hasDependents => relationships.values.contains(Relationship.child);
  bool get isUSCitizen => usCitizenStatus == USCitizenship.citizen;
  bool get isResident => usCitizenStatus == USCitizenship.resident;
  bool get isVisaHolder => usCitizenStatus == USCitizenship.visa;
  bool get isUndocumented => usCitizenStatus == USCitizenship.undocumented;
  bool get isLivingInUS => countryOfResidence == Country.us;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
