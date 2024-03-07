import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

enum Gender { male, female, nonBinary }

enum Country { us, canada, mexico, other }

enum USCitizenship { citizen, resident, visa, undocumented }

@JsonEnum()
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
  USCitizenship? usCitizenStatus;
  int? usZipCode;
  Map<String, Relationship> relationships;
// TODO decide to mark primary or not
  Person({
    bool? isPrimary,
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
  }) : uid = _generateUID(firstName, lastName, dateOfBirth);

  String get fullName => '$firstName ${middleName ?? ''} $lastName';
  bool get isAlive => livingStatus == LivingStatus.alive;
  int get age => DateTime.now().difference(dateOfBirth).inDays ~/ 365;
  int get ageAtDeath => DateTime.now().difference(dateOfDeath!).inDays ~/ 365;
  bool get isAdult => age >= 18;
  bool get isMinor => age < 18;
  bool get isSenior => age >= 65;
  int get numDependents =>
      relationships.values.where((r) => r == Relationship.child).length;
  int? get zipCode => usZipCode;
  bool get hasDependents => relationships.values.contains(Relationship.child);
  bool get isUSCitizen => usCitizenStatus == USCitizenship.citizen;
  bool get isResident => usCitizenStatus == USCitizenship.resident;
  bool get isVisaHolder => usCitizenStatus == USCitizenship.visa;
  bool get isUndocumented => usCitizenStatus == USCitizenship.undocumented;
  bool get isLivingInUS => countryOfResidence == Country.us;

  void updateUID() {
    uid = _generateUID(firstName, lastName, dateOfBirth);
  }

  static String _generateUID(
      String firstName, String lastName, DateTime dateOfBirth) {
    return '${dateOfBirth.millisecondsSinceEpoch}${firstName[0]}${lastName[0]}';
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

class PrimaryPerson extends Person {
  PrimaryPerson({
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.maritalStatus,
    required super.livingStatus,
    required super.dateOfBirth,
    super.dateOfDeath,
    required super.gender,
    required super.countryOfResidence,
    super.usCitizenStatus,
    super.usZipCode,
    required super.relationships,
  });
}
