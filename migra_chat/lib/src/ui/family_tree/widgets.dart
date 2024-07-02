import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:migra_chat/src/models/person.dart';

class PersonListTile extends StatelessWidget {
  final Person person;
  final Key? tileKey;
  final VoidCallback? onTap;

  PersonListTile({super.key, required this.person, this.tileKey, this.onTap});

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
          border: Border.all(color: Colors.black),
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
  Person focusPerson;
  Person partner;
  final VoidCallback? onTap;
  final focusedPersonKey = GlobalKey();

  CoupleListTile(
      {super.key,
      required this.focusPerson,
      required this.partner,
      this.onTap});

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
        final temp = widget.focusPerson;
        setState(() {
          widget.focusPerson = widget.partner;
          widget.partner = temp;
        });
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: AbsorbPointer(child: PersonListTile(person: widget.partner)),
          ),
          PersonListTile(
              person: widget.focusPerson, tileKey: widget.focusedPersonKey),
        ],
      ),
    );
  }
}
