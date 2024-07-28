import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:country_flags/country_flags.dart';
import 'package:migra_chat/src/data/loaders.dart';
import '../widgets.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../models/person.dart';

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

const List<String> demographics = [
  "Homeless",
  "Veteran",
  "Disabled",
  "LGBTQ+",
  "Refugee",
  "Asylee",
];

class UserIntake extends StatefulWidget {
  const UserIntake({super.key});
  @override
  State<UserIntake> createState() => _UserIntakeState();
}

final nameValidators = FormBuilderValidators.compose([
  FormBuilderValidators.required(),
  FormBuilderValidators.minLength(2),
  FormBuilderValidators.maxLength(50),
  FormBuilderValidators.match(RegExp(r'^[a-zA-Z ]*$')),
]);

final zipValidators = FormBuilderValidators.compose([
  FormBuilderValidators.required(),
  FormBuilderValidators.equalLength(5),
  FormBuilderValidators.match(RegExp(r'^[0-9]*$')),
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
                        keyboardType: TextInputType.name,
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
                        keyboardType: TextInputType.name,
                        name: "last_name",
                        decoration: const InputDecoration(
                          labelText: "Last Name",
                          hintText: "Smith",
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
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FormBuilderRadioGroup(
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: "Gender",
                              contentPadding: EdgeInsets.all(0)),
                          name: "gender",
                          options: ["Male", "Female", "Other"]
                              .map(
                                  (lang) => FormBuilderFieldOption(value: lang))
                              .toList(growable: false),
                          onChanged: (value) => setState(() {}),
                        ),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FormBuilderDateTimePicker(
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        name: "date_of_birth",
                        inputType: InputType.date,
                        decoration: const InputDecoration(
                          isDense: true,
                          labelText: "Date of Birth",
                          hintText: "01-01-2000",
                          contentPadding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              Flexible(
                  child: Row(children: [
                Flexible(
                  child: FormBuilderSwitch(
                      decoration: const InputDecoration(
                        isDense: true,
                      ),
                      name: "us_living",
                      title: const Text("Living in the US?"),
                      initialValue: false,
                      onChanged: (value) => setState(() {})),
                ),
                const SizedBox(width: 20),
                if (_formKey.currentState?.fields["us_living"]?.value == true)
                  Flexible(
                      child: FormBuilderTextField(
                    keyboardType: TextInputType.number,
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
                                  height: 10,
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
              const SizedBox(height: 10),
              Flexible(
                  flex: 2,
                  child: FormBuilderCheckboxGroup(
                    decoration: const InputDecoration(
                      labelText: "Additional Demographics",
                    ),
                    name: 'demographics',
                    options: demographics
                        .map((lang) => FormBuilderFieldOption(value: lang))
                        .toList(growable: false),
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
