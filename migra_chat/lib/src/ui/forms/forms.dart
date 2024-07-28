import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:migra_chat/src/models/government_form.dart';
import 'package:migra_chat/src/ui/widgets.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({super.key});

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Forms'),
      ),
      body: Expanded(
          child: Column(
        children: [
          const Divider(
            height: 5,
          ),
          // TabBar for TODO | Pending | Processed
          GFSegmentTabs(
            height: 50,
            width: MediaQuery.of(context).size.width,
            length: 4,
            indicator: const BoxDecoration(color: Colors.transparent),
            tabBarColor: Colors.white,
            labelColor: Colors.black,
            labelStyle: const TextStyle(fontSize: 18),
            unselectedLabelColor: Colors.black45,
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            labelPadding: EdgeInsets.zero,
            border: Border.all(color: Colors.black, width: 0),
            tabs: const [
              Tab(
                child: Text('TODO'),
              ),
              Tab(
                child: Text('Pending'),
              ),
              Tab(
                child: Text('Processed'),
              ),
              Tab(
                child: Text('All Forms'),
              ),
            ],
            tabController: _tabController,
          ),
          // Accordion for category of document
          Expanded(
            child: GFTabBarView(controller: _tabController, children: [
              Container(
                color: Colors.yellow,
              ),
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.green,
              )
            ]),
          )
        ],
      )),
    );
  }
}

class FormAccordion extends StatelessWidget {
  final ImmigrationForm formInfo;

  const FormAccordion({super.key, required this.formInfo});

  @override
  Widget build(BuildContext context) {
    return GFAccordion(
      title: '${formInfo.codeName} | ${formInfo.fullName}',
      contentChild: Column(
        children: [
          Text(formInfo.shortDescription),
          Row(
            children: [
              GFButton(
                onPressed: () {},
                text: 'View More',
                icon: const Icon(Icons.info),
              ),
              GFButton(
                onPressed: () {},
                text: 'Add to TODO',
                icon: const Icon(Icons.download),
              ),
              GFButton(
                onPressed: () {},
                text: 'Start Form',
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TODOFormTile extends StatelessWidget {
  final ImmigrationForm formInfo;
  const TODOFormTile({super.key, required this.formInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${formInfo.codeName} | ${formInfo.fullName}'),
      subtitle: Text('Last Modified: ${DateTime.now()}'),
      trailing: GFButton(
        onPressed: () {},
        text: 'Edit',
        icon: const Icon(Icons.edit),
      ),
    );
  }
}

// TODO look into the limitations of what app can do
class ProcessedFormTile extends StatelessWidget {
  final ImmigrationForm formInfo;
  const ProcessedFormTile({super.key, required this.formInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${formInfo.codeName} | ${formInfo.fullName}'),
      subtitle:
          Text('Modified: ${DateTime.now()} | Processed: ${DateTime.now()}'),
      trailing: GFButton(
        onPressed: () {},
        text: 'View',
        icon: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}

class FormCategoryAccordion extends StatelessWidget {
  const FormCategoryAccordion(
      {super.key, required this.category, required this.forms});

  final String category;
  final List<ImmigrationForm> forms;

  @override
  Widget build(BuildContext context) {
    return GFAccordion(
      title: category,
      contentChild: Column(
        children: forms.map((form) => FormAccordion(formInfo: form)).toList(),
      ),
    );
  }
}
