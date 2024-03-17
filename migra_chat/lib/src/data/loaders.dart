import './services.dart';
import '../models/person.dart';

Future<List<(String, String)>> loadCountries() async {
  final csvTable = await readCSV('assets/countries.csv');
  if (csvTable.isEmpty) {
    return [];
  }
  List<(String, String)> countries = [];
  for (var i = 1; i < csvTable.length; i++) {
    final item = csvTable[i];
    countries.add((item[0], item[2]));
  }
  return countries;
}

Future<List<Person>> loadPeople() async {
  final jsonData = await readJSON('users.json', secure: true);
  if (jsonData == null) {
    return [];
  }
  List<Person> people = [];
  for (Map<String, dynamic> item in jsonData) {
    people.add(Person.fromJson(item));
  }
  return people;
}
