import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MigraChat Web App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'MigraChat Web App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Forms'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Fees'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeesPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FeesPage extends StatefulWidget {
  const FeesPage({super.key});

  @override
  _FeesPageState createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  List<Item> _data = generateItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        title: const Text('Fees'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: _data.map<Widget>((Item item) {
          return ExpansionTile(
            title: Text(item.headerValue),
            children: item.expandedValue.map<Widget>((form) {
              return ListTile(
                title: Text(form),
                onTap: form == 'I-90'
                    ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const I90FormPage()))
                    : null,
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

class Item {
  final String headerValue;
  final List<String> expandedValue;
  Item({required this.headerValue, required this.expandedValue});
}

List<Item> generateItems() {
  return [
    Item(headerValue: 'I Forms', expandedValue: ['I-90', 'I-130', 'I-140']),
    Item(headerValue: 'N Forms', expandedValue: ['N-400', 'N-600']),
    Item(headerValue: 'G Forms', expandedValue: ['G-28', 'G-1145']),
  ];
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        title: const Text('Chat'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text('Chat page placeholder'),
      ),
    );
  }
}

class FormsPage extends StatelessWidget {
  const FormsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        title: const Text('Forms'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text('Forms page placeholder'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        title: const Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(child: Text('Home page placeholder')),
    );
  }
}

class I90FormPage extends StatefulWidget {
  const I90FormPage({super.key});

  @override
  _I90FormPageState createState() => _I90FormPageState();
}

class _I90FormPageState extends State<I90FormPage> {
  final PageController _pageController = PageController();
  DateTime? _dateOfBirth;
  DateTime? _expirationDate;
  bool? _undeliverableGreenCard;
  bool? _erroneousGreenCard;
  bool _questionsAnswered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        title: const Text('I-90 Fees'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Display Paper and Online fees
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Paper \$455', style: TextStyle(fontSize: 14)),
                Text("|", style: TextStyle(fontSize: 25)),
                Text('Online \$410', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const Divider(
            height: 0,
          ),

          // Carousel with questions
          if (!_questionsAnswered)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildDatePickerQuestion(
                      context,
                      'What is your date of birth?',
                      _dateOfBirth,
                      (date) {
                        setState(() {
                          _dateOfBirth = date;
                          _checkQuestionsAnswered();
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeIn);
                        });
                      },
                    ),
                    _buildDatePickerQuestion(
                      context,
                      'What is the expiration date of your green card?',
                      _expirationDate,
                      (date) {
                        setState(() {
                          _expirationDate = date;
                          _checkQuestionsAnswered();
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeIn);
                        });
                      },
                    ),
                    // Yes/No questions
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Was your card returned as undeliverable?',
                            style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _undeliverableGreenCard = true;
                                  _checkQuestionsAnswered();
                                });
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeIn);
                              },
                              child: const Text('Yes'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _undeliverableGreenCard = false;
                                  _checkQuestionsAnswered();
                                  _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.easeIn);
                                });
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'Was your card issued with incorrect information?',
                            style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _erroneousGreenCard = true;
                                  _checkQuestionsAnswered();
                                  _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.easeIn);
                                });
                              },
                              child: const Text('Yes'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _erroneousGreenCard = false;
                                  _checkQuestionsAnswered();
                                  _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.easeIn);
                                });
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // Display result or reset if both questions answered
          if (_questionsAnswered) ...[
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _getCostAndMessage(),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resetForm();
                });
              },
              child: const Text('Reset'),
            ),
            const Spacer()
          ],
        ],
      ),
    );
  }

  Widget _buildDatePickerQuestion(BuildContext context, String question,
      DateTime? selectedDate, Function(DateTime) onDateSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _selectDate(context, selectedDate, onDateSelected),
          child: Text(selectedDate == null
              ? 'Select Date'
              : DateFormat('yyyy-MM-dd').format(selectedDate)),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, DateTime? initialDate,
      Function(DateTime) onDateSelected) async {
    DateTime currentDate = DateTime.now();
    DateTime firstDate = DateTime(1900);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? currentDate,
      firstDate: firstDate,
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      onDateSelected(selectedDate);
    }
  }

  void _checkQuestionsAnswered() {
    if (_dateOfBirth != null &&
        _expirationDate != null &&
        _undeliverableGreenCard != null &&
        _erroneousGreenCard != null) {
      setState(() {
        _questionsAnswered = true;
      });
    }
  }

  Widget _getCostAndMessage() {
    if (_undeliverableGreenCard == true || _erroneousGreenCard == true) {
      return const Column(
        children: [
          Text(
            'Cost: \$0',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'If your card was returned as undeliverable or issued with incorrect information.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      );
    } else if (_dateOfBirth != null && _expirationDate != null) {
      int age = _calculateAge(_dateOfBirth!);
      DateTime sixteenthBirthday =
          _dateOfBirth!.add(const Duration(days: 16 * 365));

      if (age > 14 && _expirationDate!.isBefore(sixteenthBirthday)) {
        return const Column(
          children: [
            Text(
              'Cost: \$455',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'If you have reached your 14th birthday and your existing card will expire before your 16th birthday.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      } else if (age > 14 && _expirationDate!.isAfter(sixteenthBirthday)) {
        return const Column(
          children: [
            Text(
              'Cost: \$0',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'If you have reached your 14th birthday, and your existing card will expire after your 16th birthday.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      }
    }
    return const Text('Varies');
  }

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void _resetForm() {
    _dateOfBirth = null;
    _expirationDate = null;
    _undeliverableGreenCard = false;
    _erroneousGreenCard = false;
    _questionsAnswered = false;
  }
}
