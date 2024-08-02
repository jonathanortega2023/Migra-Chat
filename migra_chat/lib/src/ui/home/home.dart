import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:migra_chat/src/ui/widgets.dart';
import 'package:migra_chat/src/data/mock.dart';
import 'package:migra_chat/src/models/person.dart';
import 'package:easy_stepper/easy_stepper.dart';

Person primaryPerson = getPeople().firstWhere((element) => element.isPrimary);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        drawer: const AppDrawer(),
        body: const Expanded(
          child: Column(
            children: [
              UserInfoTile(),
              Divider(),
              CitizenshipStatusBar(),
              Divider(),
              FormsBreakdown(),
              Divider(),
              KeepReadingButton()
            ],
          ),
        ));
  }
}

// ListTile with leading icon/age and Name/Residence
class UserInfoTile extends StatelessWidget {
  const UserInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: const GFAvatar(
        size: 50,
        backgroundImage: NetworkImage(
            'https://upload.wikimedia.org/wikipedia/en/0/02/Homer_Simpson_2006.png'),
      ),
      title: Text('${primaryPerson.firstName} ${primaryPerson.lastName}'),
      subTitle: Text('${primaryPerson.countryOfResidence}'),
    );
  }
}

class CitizenshipStatusBar extends StatelessWidget {
  const CitizenshipStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const EasyStepper(
      showLoadingAnimation: false,
      activeStep: 0,
      steps: [
        EasyStep(
          title: "Nonimmigrant Visa Holder\n(Temporary Status)",
          icon: Icon(Icons.punch_clock),
          topTitle: true,
          enabled: false,
        ),
        EasyStep(
          title: "Legal Permanent Resident\n(Green Card Holder)",
          icon: Icon(Icons.card_membership),
          enabled: false,
        ),
        EasyStep(
          title: "Naturalization Applicant",
          icon: Icon(Icons.how_to_reg),
          topTitle: true,
          enabled: false,
        ),
        EasyStep(
          title: "U.S. Citizen",
          icon: Icon(Icons.flag),
          enabled: false,
        ),
      ],
    );
  }
}

const VerticalDivider formSectionsVerticalDivider = VerticalDivider(
  color: Colors.grey,
  width: 1,
  thickness: 1,
);

// Row with 3 sections, each with a title and a number (links to forms page). TODO | Pending | Processed
class FormsBreakdown extends StatelessWidget {
  const FormsBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Pending'),
                Text('0'),
              ],
            ),
            formSectionsVerticalDivider,
            Column(
              children: [
                Text('Processed'),
                Text('0'),
              ],
            ),
            formSectionsVerticalDivider,
            Column(
              children: [
                Text('Total'),
                Text('0'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Button that links to the most recently read content
class KeepReadingButton extends StatelessWidget {
  const KeepReadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
