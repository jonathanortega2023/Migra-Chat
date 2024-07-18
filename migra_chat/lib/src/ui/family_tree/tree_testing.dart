// TODO Fix behavior when selecting bart/maggie/lisa
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:migra_chat/src/models/person.dart';
import 'package:migra_chat/src/data/mock.dart';
import 'package:migra_chat/src/ui/family_tree/widgets.dart';
import 'package:migra_chat/src/ui/widgets.dart';

final allPeople = getPeople();
final allPeopleMap = getPeopleMap();

class FamilyTree extends StatefulWidget {
  @override
  _FamilyTreeState createState() => _FamilyTreeState();
}

class _FamilyTreeState extends State<FamilyTree> {
  Person focusPerson = allPeople.firstWhere((element) => element.isPrimary);
  List<Person> focusRelatives = [];
  Map<String, Person> focusRelativesMap = {};
  List<Node> focusNodes = [];

  Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    filterFocusRelatives();
    createFocusNodes();
    getFocusPersonEdges();
    configureBuilder();
  }

  void filterFocusRelatives() {
    for (Person person in allPeople) {
      if (person == focusPerson) {
        focusRelatives.add(person);
        continue;
      }
      final bool personIsAncestor = person.isAncestorOf(focusPerson);
      final bool personIsDescendant = person.isDescendantOf(focusPerson);
      if (personIsAncestor || personIsDescendant) {
        focusRelatives.add(person);
      }
    }
    focusRelativesMap = {
      for (Person person in focusRelatives) person.uid: person
    };

    // Remove one member of each couple from the map
    final Set<String> removedSpouses = {};

    for (int i = 0; i < focusRelatives.length; i++) {
      final Person person = focusRelatives[i];
      if (person.hasSpouse && focusRelativesMap.containsKey(person.spouseUID)) {
        if (!removedSpouses.contains(person.spouseUID)) {
          // Remove this person and mark their spouse as removed
          focusRelativesMap.remove(person.uid);
          removedSpouses.add(person.spouseUID!);
        }
      }
    }

    focusRelatives = focusRelativesMap.values.toList();
  }

  void createFocusNodes() {
    for (Person person in focusRelatives) {
      final Node node = Node.Id(person.uid);
      graph.addNode(node);
      focusNodes.add(node);
    }
  }

  void configureBuilder() {
    builder
      ..siblingSeparation = 50
      ..levelSeparation = 75
      ..subtreeSeparation = 150
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT;
  }

  void getFocusPersonEdges() {
    final Map<String, Node> nodeMap = {
      for (Node node in focusNodes) node.key!.value as String: node
    };
    for (Person person in focusRelatives) {
      final Node personNode = nodeMap[person.uid]!;
      final List<Person> personChildren = person.getChildren();
      for (Person child in personChildren) {
        if (focusRelativesMap.containsKey(child.uid)) {
          final Node childNode = nodeMap[child.uid]!;
          graph.addEdge(personNode, childNode);
        } else {
          final Node childNode = Node.Id(child.uid);
          graph.addNode(childNode);
          graph.addEdge(personNode, childNode);
          focusNodes.add(childNode);
        }
      }
    }
  }

  void resetFocusPerson() {
    setState(() {
      focusRelatives = [];
      focusRelativesMap = {};
      focusNodes = [];
      graph = Graph()..isTree = true;
      builder = BuchheimWalkerConfiguration();
      filterFocusRelatives();
      createFocusNodes();
      getFocusPersonEdges();
      configureBuilder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Family Tree'),
        // TODO QR Code for sharing
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.01,
        maxScale: 5.6,
        child: GraphView(
          graph: graph,
          algorithm:
              BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
          paint: Paint()
            ..color = Colors.blue
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke,
          builder: (Node node) {
            final Person person = allPeopleMap[node.key!.value as String]!;
            if (person.hasSpouse) {
              final Person spouse = allPeopleMap[person.spouseUID]!;
              return CoupleListTile(
                primaryPerson: person,
                partner: spouse,
                focused: person == focusPerson,
                onTap: () {
                  setState(() {
                    focusPerson = spouse;
                  });
                  resetFocusPerson();
                },
              );
            } else {
              return PersonListTile(
                  person: person,
                  focused: person == focusPerson,
                  onTap: () {
                    setState(() {
                      focusPerson = person;
                    });
                    resetFocusPerson();
                  });
            }
          },
        ),
      ),
    );
  }
}
