import './services.dart';

Future<List<(String,String)>> loadCountries() async {
  final csvTable = await readCSV('assets/countries.csv');
  if (csvTable.isEmpty) {
    return [];
  }
  List<(String,String)> countries = [];
  for (var i = 1; i < csvTable.length; i++) {
    final item = csvTable[i];
    countries.add((item[0], item[2]));
  }
  return countries;
}