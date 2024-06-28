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

void writeToJSON(String fileName, Map<String, dynamic> jsonData,
    {bool secure = false, String? filePath}) async {
  late Directory directory;
  if (filePath == null) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    directory = Directory(filePath);
  }
  final file = File('${directory.path}/$fileName');

  await file.writeAsString(jsonEncode(jsonData));
  if (secure) {
    await storage.write(key: fileName, value: file.path);
  }
}

dynamic readJSON(String fileName, {bool secure = false}) async {
  if (!secure) {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    if (!await file.exists()) {
      throw Exception('File does not exist');
    }
    final jsonData = await file.readAsString();
    return jsonDecode(jsonData);
  }
  final filePath = await storage.read(key: fileName);
  if (filePath == null) {
    throw Exception('Filepath not found in secure storage');
  }
  final file = File(filePath);
  if (!await file.exists()) {
    throw Exception('File does not exist');
  }
  final jsonData = await file.readAsString();
  return jsonDecode(jsonData);
}

// relevant code for users file compression
// final compressed = gzip.encode(jsonEncode(allPeople).codeUnits);
// final qrCode = QrCode.fromUint8List(
//     data: Uint8List.fromList(compressed), errorCorrectLevel: 0);
