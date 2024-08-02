// on modification, run command: `dart run build_runner build`
import 'dart:html';
import 'package:json_annotation/json_annotation.dart';

@jsonSerializable
class USCISForm {
  String formCategory;
  String formNumber;
  String formTitle;
  bool onlineFileable;
  String shortDescription;
  String longDescription;
  Url pageURL;
  Url documentURL;
  List<Map<String, Url>> relatedFormsFilenamesAndURLs;

  USCISForm({
    required this.formCategory,
    required this.formNumber,
    required this.formTitle,
    required this.onlineFileable,
    required this.shortDescription,
    required this.longDescription,
    required this.pageURL,
    required this.documentURL,
    this.instructionsURL,
  })  : assert(formCategory.trim().isNotEmpty),
        assert(formNumber.trim().isNotEmpty),
        assert(formTitle.trim().isNotEmpty),
        assert(shortDescription.trim().isNotEmpty),
        assert(longDescription.trim().isNotEmpty);
}

class USCISFormFeeSchedule {}
