import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_flags/country_flags.dart';
import 'package:migra_chat/src/data/loaders.dart';
import '../widgets.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../models/person.dart';
import '../../data/services.dart';

// ignore: non_constant_identifier_names
final Person ME = Person(
  isPrimary: true,
  firstName: "John",
  middleName: "Doe",
  lastName: "Smith",
  gender: Gender.male,
  usCitizenStatus: USCitizenship.citizen,
  countryOfResidence: Country.us,
  usZipCode: '60647',
  livingStatus: LivingStatus.alive,
  maritalStatus: MaritalStatus.married,
  dateOfBirth: DateTime(1998, 5, 29),
  relationships: {},
);

class UserIntake extends StatefulWidget {
  const UserIntake({super.key});
  @override
  State<UserIntake> createState() => _UserIntakeState();
}

final nameValidators = FormBuilderValidators.compose([
  FormBuilderValidators.required(),
  FormBuilderValidators.minLength(1),
  FormBuilderValidators.maxLength(50),
  FormBuilderValidators.match(r'^[a-zA-Z ]*$'),
]);

final zipValidators = FormBuilderValidators.compose([
  FormBuilderValidators.required(),
  FormBuilderValidators.equalLength(5),
  FormBuilderValidators.match(r'^[0-9]*$'),
]);

String _cleanString(String value) {
  // use regex to remove extra whitespace
  return value.trim().replaceAll(RegExp(r'\s+'), ' ');
}

class _UserIntakeState extends State<UserIntake> {
  List<(String, String)> countries = [];

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: GFAppBar(
        title: const Text('Intake'),
      ),
      body: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              Flexible(
                child: Row(
                  children: [
                    Flexible(
                      child: FormBuilderTextField(
                        validator: nameValidators,
                        name: "first_name",
                        decoration: const InputDecoration(
                          labelText: "First Name",
                          hintText: "John",
                          icon: Icon(Icons.person),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: FormBuilderTextField(
                        name: "middle_name",
                        decoration: const InputDecoration(
                          labelText: "Middle Name",
                          hintText: "Doe",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                  child: Row(
                children: [
                  Flexible(
                    child: FormBuilderTextField(
                      name: "last_name",
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                        hintText: "Smith",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: FormBuilderDateTimePicker(
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      name: "date_of_birth",
                      inputType: InputType.both,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: "Date of Birth",
                        hintText: "01-01-2000",
                      ),
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 20),
              Flexible(
                  child: FormBuilderRadioGroup(
                decoration: const InputDecoration(labelText: "Gender"),
                name: "gender",
                options: ["Male", "Female", "Other"]
                    .map((lang) => FormBuilderFieldOption(value: lang))
                    .toList(growable: false),
                onChanged: (value) => setState(() {}),
              )),
              const SizedBox(height: 20),
              Flexible(
                  child:
                      // marital status radio options
                      FormBuilderRadioGroup(
                decoration: const InputDecoration(labelText: "Marital Status"),
                name: "marital_status",
                options: ["Single", "Married", "Divorced", "Widowed"]
                    .map((lang) => FormBuilderFieldOption(value: lang))
                    .toList(growable: false),
                onChanged: (value) => setState(() {}),
              )),
              const SizedBox(height: 20),
              Flexible(
                child: FormBuilderRadioGroup(
                    decoration: const InputDecoration(
                      labelText: "US Citizen Status",
                    ),
                    name: "us_citizen_status",
                    options: ["Citizen", "Resident", "Visa", "Undocumented"]
                        .map((lang) => FormBuilderFieldOption(value: lang))
                        .toList(growable: false),
                    onChanged: (value) => setState(() {})),
              ),
              const SizedBox(height: 20),
              Flexible(
                  child: Row(children: [
                Flexible(
                  child: FormBuilderSwitch(
                      name: "us_living",
                      title: const Text("Living in the US?"),
                      initialValue: false,
                      onChanged: (value) => setState(() {})),
                ),
                const SizedBox(width: 20),
                if (_formKey.currentState?.fields["us_living"]?.value == true)
                  Flexible(
                      child: FormBuilderTextField(
                    name: "us_zip",
                    decoration: const InputDecoration(
                      labelText: "US Zip Code",
                      hintText: "12345",
                    ),
                  ))
                else
                  Flexible(
                      child: FormBuilderDropdown(
                    name: "country_living",
                    decoration: const InputDecoration(
                      labelText: "Country Living In",
                    ),
                    items: [
                      for ((String, String) country in countries)
                        if (country.$2 != "US")
                          DropdownMenuItem(
                            value: country.$1,
                            child: Row(
                              children: [
                                CountryFlag.fromCountryCode(
                                  country.$2,
                                  height: 20,
                                  width: 30,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                  country.$1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ],
                            ),
                          )
                    ],
                  )),
              ])),
              const SizedBox(height: 20),
              if (_formKey.currentState?.fields["us_citizen_status"]?.value !=
                      "Citizen" &&
                  _formKey.currentState?.fields["us_living"]?.value == true)
                Flexible(
                    child: FormBuilderDateTimePicker(
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  name: "date_of_entry",
                  inputType: InputType.date,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: "Date of Entry",
                    hintText: "01-01-2000",
                  ),
                )),
              const SizedBox(height: 20),
              Flexible(
                  child: Row(
                children: [
                  GFButton(
                      child: const Text("Read Users"),
                      onPressed: () async {
                        // TODO Actually implement this
                        print(await readJSON('users.json'));
                        print("Read from users.json!");
                        if (_formKey.currentState?.saveAndValidate() == true) {
                          final data = _formKey.currentState?.value;
                          print(data);
                        }
                      }),
                  const SizedBox(width: 20),
                  GFButton(
                    child: const Text("Save User"),
                    onPressed: () async {
                      // TODO Actually implement this
                      await writeToJSON('users.json', ME.toJson());
                      print("Wrote to users.json!");
                    },
                  ),
                ],
              ))
            ]),
          )),
    );
  }

  void _loadCountries() async {
    countries = await loadCountries();
    setState(() {});
  }

  @override
  void initState() {
    _loadCountries();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
