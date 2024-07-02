// on modification, run command: `dart run build_runner build`
// TODO Refactor to store parents and children as separate lists

import 'package:json_annotation/json_annotation.dart';
import 'package:migra_chat/src/data/mock.dart';
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
  Gender? gender;
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
    this.gender,
    this.countryOfResidence,
    required this.usCitizenStatus,
    this.usZipCode,
    required this.relationships,
  })  : assert(firstName.trim().isNotEmpty && lastName.trim().isNotEmpty),
        assert(dateOfBirth.isBefore(DateTime.now()) && dateOfBirth.year > 1900),
        assert(dateOfDeath == null || dateOfDeath.isAfter(dateOfBirth)),
        assert(usZipCode == null || usZipCode.toString().length == 5),
        uid = const Uuid().v4();
  // maybe use timestamp once not using mock data
  // uid = DateTime.now().microsecondsSinceEpoch.toString();

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
  // TODO Think about this
  bool get isMarried => maritalStatus == MaritalStatus.married;
  bool get hasSpouse => relationships.values.contains(Relationship.spouse);
  String? get spouseUID {
    if (!hasSpouse) return null;
    return relationships.entries
        .firstWhere((element) => element.value == Relationship.spouse)
        .key;
  }

  void addRelationship(Person person, Relationship relation) {
    relationships[person.uid] = relation;
  }

  void removeRelationship(Person person) {
    relationships.remove(person.uid);
  }

  void updateRelationship(Person person, Relationship relation) {
    relationships.update(person.uid, (value) => relation);
  }

  void addChildren(List<Person> children, {Person? spouse}) {
    assert(children.isNotEmpty, 'Children list cannot be empty');

    for (Person child in children) {
      addChild(child, spouse: spouse);
    }
    // make all children siblings of each other, maybe call addSiblings()?
    for (Person child in children) {
      for (Person otherChild in children) {
        if (child != otherChild) {
          child.addSibling(otherChild);
        }
      }
    }
  }

  void addChild(Person child, {Person? spouse}) {
    // copy over other children as siblings
    relationships.forEach((key, value) {
      if (value == Relationship.child) {
        child.relationships[key] = Relationship.sibling;
      }
    });
    relationships[child.uid] = Relationship.child;
    child.relationships[uid] = Relationship.parent;

    if (spouse == null) return;
    if (!hasSpouse) {
      throw Exception('Person is not married');
    }
    spouse.relationships[child.uid] = Relationship.child;
    child.relationships[spouse.uid] = Relationship.parent;
  }

  List<Person> getChildren() {
    return relationships.entries
        .where((element) => element.value == Relationship.child)
        .map((e) => getPerson(e.key))
        .toList();
  }

  void addSiblings(List<Person> siblings) {
    assert(siblings.isNotEmpty, 'Siblings list cannot be empty');
    for (Person sibling in siblings) {
      addSibling(sibling);
    }
    for (Person sibling in siblings) {
      for (Person otherSibling in siblings) {
        if (sibling != otherSibling) {
          sibling.addSibling(otherSibling);
        }
      }
    }
  }

  void addSibling(Person sibling) {
    relationships[sibling.uid] = Relationship.sibling;
    sibling.relationships[uid] = Relationship.sibling;
  }

  void addSpouse(Person spouse) {
    if (hasSpouse || spouse.hasSpouse) {
      throw Exception('Person is already married');
    }
    relationships[spouse.uid] = Relationship.spouse;
    spouse.relationships[uid] = Relationship.spouse;
  }

  bool isAncestorOf(Person other) {
    // Base case: if the other person has this person's UID as a parent
    if (other.relationships.containsKey(uid) &&
        other.relationships[uid] == Relationship.parent) {
      return true;
    }

    // Recursively check if any child of this person is an ancestor of the other person
    for (String childUid in relationships.keys
        .where((k) => relationships[k] == Relationship.child)) {
      Person child = getPerson(childUid);
      if (child.isAncestorOf(other)) {
        return true;
      }
    }

    // If no match found, return false
    return false;
  }

  bool isDescendantOf(Person other) {
    return other.isAncestorOf(this);
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
