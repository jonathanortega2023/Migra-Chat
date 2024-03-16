import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = const FlutterSecureStorage();

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
  await storage.write(key: fileName, value: file.path);
  print(jsonData);
  print('Wrote to ${file.path}');
}

dynamic readJSON(String fileName) async {
  final filePath = await storage.read(key: fileName);
  if (filePath == null) {
    return null;
  }
  final file = File(filePath);
  if (!await file.exists()) {
    return null;
  }
  final jsonData = await file.readAsString();
  print('Read from ${file.path}');
  print(jsonData);
  return jsonDecode(jsonData);
}
