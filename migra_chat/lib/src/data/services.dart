import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

Future<List<List<dynamic>>> readCSV(String path, {String? eol = '\n'}) async {
  late String rawData;
  try {
    rawData = await rootBundle.loadString(path);
  } catch (e) {
    return [];
  }
  final csvTable = const CsvToListConverter().convert(
    rawData,
    eol: eol,
    shouldParseNumbers: false,
  );
  return csvTable;
}

// TODO ponder if this needs to be abstract or not

Future<void> writeToJSON(String fileName, Map<String, dynamic> jsonData) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$fileName');
  await file.writeAsString(jsonEncode(jsonData));
  print(jsonData);
  print('Wrote to ${file.path}');
}

dynamic readJSON(String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$fileName');
  if (await file.exists()) {
    final jsonData = await file.readAsString();
    return jsonDecode(jsonData);
  }
  return null;
}
