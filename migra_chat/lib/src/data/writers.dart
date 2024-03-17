import './services.dart';
import '../models/person.dart';

savePerson(Person person) async {
  writeToJSON('users.json', person.toJson(), secure: true);
}

updatePerson(Person person) async {
  final jsonData = await readJSON('users.json', secure: true);
  if (jsonData == null) {
    return;
  }
  final index = jsonData.indexWhere((element) => element['uid'] == person.uid);
  if (index == -1) {
    return;
  }
  jsonData[index] = person.toJson();
  writeToJSON('users.json', jsonData, secure: true);
}

deletePerson(Person person) async {
  final jsonData = await readJSON('users.json', secure: true);
  if (jsonData == null) {
    return;
  }
  final index = jsonData.indexWhere((element) => element['uid'] == person.uid);
  if (index == -1) {
    return;
  }
  jsonData.removeAt(index);
  writeToJSON('users.json', jsonData, secure: true);
}
