import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:migra_chat/src/models/person.dart';
import 'package:migra_chat/src/data/mock.dart';

final people = getPeople();

class FamilyTreeView extends StatefulWidget {
  @override
  _FamilyTreeViewState createState() => _FamilyTreeViewState();
}

class _FamilyTreeViewState extends State<FamilyTreeView> {
  var homerJSON = {
    'nodes': [
      {'id': 1, 'label': 'Abe'},
      {'id': 2, 'label': 'Mona'},
      {'id': 3, 'label': 'Homer'},
      {'id': 4, 'label': 'Marge'},
      {'id': 5, 'label': 'Bart'},
      {'id': 6, 'label': 'Lisa'},
      {'id': 7, 'label': 'Maggie'},
      {'id': 8, 'label': 'Patty'},
      {'id': 9, 'label': 'Selma'},
      {'id': 10, 'label': 'Jacqueline'},
    ],
    'edges': [
      {'from': 1, 'to': 3},
      {'from': 2, 'to': 3},
      {'from': 3, 'to': 5},
      {'from': 3, 'to': 6},
      {'from': 3, 'to': 7},
      {'from': 4, 'to': 5},
      {'from': 4, 'to': 6},
      {'from': 4, 'to': 7},
      {'from': 10, 'to': 8},
      {'from': 10, 'to': 9},
      {'from': 10, 'to': 4},
    ]
  };

  var margeJSON = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Wrap(
              children: [
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: builder.siblingSeparation.toString(),
                    decoration:
                        InputDecoration(labelText: 'Sibling Separation'),
                    onChanged: (text) {
                      builder.siblingSeparation = int.tryParse(text) ?? 100;
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: builder.levelSeparation.toString(),
                    decoration: InputDecoration(labelText: 'Level Separation'),
                    onChanged: (text) {
                      builder.levelSeparation = int.tryParse(text) ?? 100;
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: builder.subtreeSeparation.toString(),
                    decoration:
                        InputDecoration(labelText: 'Subtree separation'),
                    onChanged: (text) {
                      builder.subtreeSeparation = int.tryParse(text) ?? 100;
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: builder.orientation.toString(),
                    decoration: InputDecoration(labelText: 'Orientation'),
                    onChanged: (text) {
                      builder.orientation = int.tryParse(text) ?? 100;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: SugiyamaAlgorithm(
                      SugiyamaConfiguration(),
                    ),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      var a = node.key!.value as int?;

                      var nodes = homerJSON['nodes']!;
                      var nodeValue =
                          nodes.firstWhere((element) => element['id'] == a);
                      return rectangleWidget(nodeValue['label'] as String?);
                    },
                  )),
            ),
          ],
        ));
  }

  Widget rectangleWidget(String? a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('${a}')),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    var edges = homerJSON['edges']!;
    for (var element in edges) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId),
          paint: Paint()
            ..color = Colors.red
            ..strokeWidth = 50);
    }

    builder
      ..siblingSeparation = (50)
      ..levelSeparation = (100)
      ..subtreeSeparation = (100)
      ..orientation = (3);
  }
}
