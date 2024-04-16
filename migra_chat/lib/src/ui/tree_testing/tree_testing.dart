import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:migra_chat/src/models/person.dart';

class FamilyTreeView extends StatefulWidget {
  @override
  _FamilyTreeViewState createState() => _FamilyTreeViewState();
}

class _FamilyTreeViewState extends State<FamilyTreeView> {
  var json = {
    'nodes': [
      {'id': 1, 'label': 'jon'},
      {'id': 2, 'label': 'alysha'},
      {'id': 3, 'label': 'alexa'},
      {'id': 4, 'label': 'aaliyah'},
      {'id': 5, 'label': 'ryan'},
      {'id': 6, 'label': 'ramon'},
      {'id': 7, 'label': 'luisa'},
    ],
    'edges': [
      {'from': 6, 'to': 1},
      {'from': 6, 'to': 2},
      {'from': 6, 'to': 3},
      {'from': 6, 'to': 4},
      {'from': 7, 'to': 1},
      {'from': 7, 'to': 2},
      {'from': 7, 'to': 3},
      {'from': 7, 'to': 4},
    ]
  };

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
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // if node id is 6, show a stack of widgets with offset if 7, show nothing
                      // I can decide what widget should be shown here based on the id
                      var a = node.key!.value as int?;
                      if (a == 7) {
                        return SizedBox.shrink();
                      } else if (a == 6) {
                        return Stack(
                          children: [
                            Positioned(
                              left: 100,
                              bottom: 100,
                              child: rectangleWidget('luisa'),
                            ),
                            rectangleWidget('ramon'),
                          ],
                        );
                      }
                      var nodes = json['nodes']!;
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
            boxShadow: [
              BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
            ],
          ),
          child: Text('${a}')),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    var edges = json['edges']!;
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
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}
