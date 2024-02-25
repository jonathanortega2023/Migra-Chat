enum Gender { male, female, nonBinary }

enum Country { us, canada, mexico, other }

enum USCitizenship { citizen, resident, visa, undocumented }

enum Relationship { parent, child, sibling, stepchild, stepSibling, stepParent, spouse, exSpouse}

enum LivingStatus { alive, deceased }

enum MaritalStatus { single, married, divorced, widowed }

class Person {
  String firstName;
  String? middleName;
  String lastName;
  LivingStatus livingStatus;
  MaritalStatus? maritalStatus;
  DateTime dateOfBirth;
  Gender gender;
  Country? countryOfResidence;
  USCitizenship? usCitizenStatus;
  int? usZipCode;
  Map<Person, Relationship> relationships;

  Person({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.livingStatus,
    required this.maritalStatus,
    required this.dateOfBirth,
    required this.gender,
    this.countryOfResidence,
    required this.usCitizenStatus,
    this.usZipCode,
    required this.relationships,
  });

  String get fullName => '$firstName ${middleName ?? ''} $lastName';
  bool get isAlive => livingStatus == LivingStatus.alive;
  int get age => DateTime.now().difference(dateOfBirth).inDays ~/ 365;
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
}

class PrimaryPerson extends Person {
  PrimaryPerson({
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.livingStatus,
    required super.maritalStatus,
    required super.dateOfBirth,
    required super.gender,
    required super.countryOfResidence,
    super.usCitizenStatus,
    super.usZipCode,
    required super.relationships,
  }) ;
}