class ImmigrationForm {
  String formCategory;
  String codeName;
  String fullName;
  bool onlineFileable;
  String shortDescription;
  String longDescription;
  Uri pageURL;
  Uri documentURL;
  Uri? instructionsURL;

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
        assert(longDescription.trim().isNotEmpty),
        assert(pageURL.isScheme('https') || pageURL.isScheme('http')),
        assert(documentURL.isScheme('https') || documentURL.isScheme('http')),
        assert(instructionsURL == null ||
            instructionsURL.isScheme('https') ||
            instructionsURL.isScheme('http'));
}

// TODO ponder subclass implementation for progress/processed