// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      isPrimary: json['isPrimary'] as bool,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,
      livingStatus: $enumDecode(_$LivingStatusEnumMap, json['livingStatus']),
      maritalStatus:
          $enumDecodeNullable(_$MaritalStatusEnumMap, json['maritalStatus']),
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      dateOfDeath: json['dateOfDeath'] == null
          ? null
          : DateTime.parse(json['dateOfDeath'] as String),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      countryOfResidence:
          $enumDecodeNullable(_$CountryEnumMap, json['countryOfResidence']),
      usCitizenStatus:
          $enumDecodeNullable(_$USCitizenshipEnumMap, json['usCitizenStatus']),
      usZipCode: json['usZipCode'] as String?,
      relationships: (json['relationships'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, $enumDecode(_$RelationshipEnumMap, e)),
      ),
    )
      ..uid = json['uid'] as String
      ..dateOfEntry = json['dateOfEntry'] == null
          ? null
          : DateTime.parse(json['dateOfEntry'] as String);

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'isPrimary': instance.isPrimary,
      'uid': instance.uid,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'livingStatus': _$LivingStatusEnumMap[instance.livingStatus]!,
      'maritalStatus': _$MaritalStatusEnumMap[instance.maritalStatus],
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'dateOfDeath': instance.dateOfDeath?.toIso8601String(),
      'gender': _$GenderEnumMap[instance.gender]!,
      'countryOfResidence': _$CountryEnumMap[instance.countryOfResidence],
      'dateOfEntry': instance.dateOfEntry?.toIso8601String(),
      'usCitizenStatus': _$USCitizenshipEnumMap[instance.usCitizenStatus],
      'usZipCode': instance.usZipCode,
      'relationships': instance.relationships
          .map((k, e) => MapEntry(k, _$RelationshipEnumMap[e]!)),
    };

const _$LivingStatusEnumMap = {
  LivingStatus.alive: 'alive',
  LivingStatus.deceased: 'deceased',
};

const _$MaritalStatusEnumMap = {
  MaritalStatus.single: 'single',
  MaritalStatus.married: 'married',
  MaritalStatus.divorced: 'divorced',
  MaritalStatus.widowed: 'widowed',
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.nonBinary: 'nonBinary',
};

const _$CountryEnumMap = {
  Country.us: 'us',
  Country.canada: 'canada',
  Country.mexico: 'mexico',
  Country.other: 'other',
};

const _$USCitizenshipEnumMap = {
  USCitizenship.citizen: 'citizen',
  USCitizenship.resident: 'resident',
  USCitizenship.visa: 'visa',
  USCitizenship.undocumented: 'undocumented',
};

const _$RelationshipEnumMap = {
  Relationship.parent: 'parent',
  Relationship.child: 'child',
  Relationship.sibling: 'sibling',
  Relationship.stepchild: 'stepchild',
  Relationship.stepSibling: 'stepSibling',
  Relationship.stepParent: 'stepParent',
  Relationship.spouse: 'spouse',
  Relationship.exSpouse: 'exSpouse',
};
