import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:migra_chat/src/models/person.dart';

class PersonListTile extends StatelessWidget {
  final Person person;
  final Key? tileKey;
  final VoidCallback? onTap;
  final bool focused;

  const PersonListTile(
      {super.key,
      required this.person,
      this.tileKey,
      this.onTap,
      this.focused = false});

  @override
  Widget build(BuildContext context) {
    final GFAvatar avatarContent;
    // if (person.avatar != null) {
    //   avatarContent = Image.memory(person.avatar);
    // } else {
    // avatarContent =
    //     GFAvatar(child: Text('${person.firstName[0]}${person.lastName[0]}'));
    // }
    avatarContent =
        GFAvatar(child: Text('${person.firstName[0]}${person.lastName[0]}'));
    final borderRadius = BorderRadius.circular(25);
    final tileColor = Colors.blueGrey[100];

    return Container(
      decoration: BoxDecoration(
          color: tileColor,
          border: Border.all(color: Colors.black, width: focused ? 3 : 1),
          borderRadius: borderRadius),
      width: 250,
      child: ListTile(
        key: tileKey,
        onTap: onTap,
        tileColor: tileColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        title: Text(
          maxLines: 1,
          '${person.firstName} ${person.lastName}',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // spacing within the tile
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
        trailing: GFAvatar(
          child: avatarContent,
        ),
      ),
    );
  }
}

class CoupleListTile extends StatefulWidget {
  Person primaryPerson;
  Person partner;
  final VoidCallback? onTap;
  final focusedPersonKey = GlobalKey();
  final bool focused;

  CoupleListTile(
      {super.key,
      required this.primaryPerson,
      required this.partner,
      this.onTap,
      this.focused = false});

  @override
  _CoupleListTileState createState() => _CoupleListTileState();
}

class _CoupleListTileState extends State<CoupleListTile> {
  _CoupleListTileState();
  // TODO Add slide/elevation animation to swap focusPerson and partner

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
        // Swap focusPerson and partner
        final temp = widget.primaryPerson;
        setState(() {
          widget.primaryPerson = widget.partner;
          widget.partner = temp;
        });
      },
      // Draws to center of couple tile instead
      // child: Stack(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(top: 25),
      //       child: AbsorbPointer(child: PersonListTile(person: widget.partner)),
      //     ),
      //     PersonListTile(
      //         person: widget.focusPerson, tileKey: widget.focusedPersonKey),
      //   ],
      // ),
      child: Stack(
        children: [
          Transform.translate(
              offset: const Offset(0, 25),
              child: PersonListTile(person: widget.partner)),
          PersonListTile(
              person: widget.primaryPerson,
              focused: widget.focused,
              tileKey: widget.focusedPersonKey),
        ],
      ),
    );
  }
}
