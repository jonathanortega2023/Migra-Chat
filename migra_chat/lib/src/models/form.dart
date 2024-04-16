import 'dart:html';

class ImmigrationForm {
  String formCategory;
  String codeName;
  String fullName;
  bool onlineFileable;
  String shortDescription;
  String longDescription;
  Url pageURL;
  Url documentURL;
  Url? instructionsURL;

  ImmigrationForm({
    required this.formCategory,
    required this.codeName,
    required this.fullName,
    required this.onlineFileable,
    required this.shortDescription,
    required this.longDescription,
    required this.pageURL,
    required this.documentURL,
    this.instructionsURL,
  })  : assert(formCategory.trim().isNotEmpty),
        assert(codeName.trim().isNotEmpty),
        assert(fullName.trim().isNotEmpty),
        assert(shortDescription.trim().isNotEmpty),
        assert(longDescription.trim().isNotEmpty);
}
