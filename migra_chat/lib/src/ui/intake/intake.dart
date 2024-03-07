import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_flags/country_flags.dart';
import 'package:migra_chat/src/data/loaders.dart';

class UserIntake extends StatefulWidget {
  const UserIntake({super.key});
  @override
  State<UserIntake> createState() => _UserIntakeState();
}

// const NAME_VALIDATORS = [
//   FormBuilderValidators.required(),
//   FormBuilderValidators.minLength(2),
//   FormBuilderValidators.maxLength(50),

// ];

class _UserIntakeState extends State<UserIntake> {
  List<(String, String)> countries = [];

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          hintText: "Richard",
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
                        hintText: "Doe",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: FormBuilderDateTimePicker(
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
                decoration: const InputDecoration(
                  labelText: "Gender"),
                name: "gender",
                options: ["Male", "Female", "Other"]
                    .map((lang) => FormBuilderFieldOption(value: lang))
                    .toList(growable: false),
              )),
              const SizedBox(height: 20),
              Flexible(
                  child:
                      // marital status radio options
                      FormBuilderRadioGroup(
                decoration: const InputDecoration(
                  labelText: "Marital Status"
                ),
                name: "marital_status",
                options: ["Single", "Married", "Divorced", "Widowed"]
                    .map((lang) => FormBuilderFieldOption(value: lang))
                    .toList(growable: false),
              )),
              const SizedBox(height: 20),
              Flexible(
                child: FormBuilderRadioGroup(
                  decoration: const InputDecoration(
                    labelText: "US Citizen Status"
                ),
                  name: "us_citizen_status",
                  options: ["Citizen", "Resident", "Visa", "Undocumented"]
                      .map((lang) => FormBuilderFieldOption(value: lang))
                      .toList(growable: false),
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                  child: Row(children: [
                Flexible(
                  child: FormBuilderSwitch(
                    name: "us_living",
                    title: const Text("Living in the US?"),
                    initialValue: false,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
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
              ]))
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
