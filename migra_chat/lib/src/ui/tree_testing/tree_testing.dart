import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:vector_math/vector_math_64.dart' show Matrix4;

class FamilyTreeView extends StatefulWidget {
  @override
  _FamilyTreeViewState createState() => _FamilyTreeViewState();
}

class _FamilyTreeViewState extends State<FamilyTreeView> {
  final Map<String, dynamic> familyJson = {
    'nodes': [
      {'id': 1, 'label': 'Grandpa'},
      {'id': 2, 'label': 'Grandma'},
      {'id': 3, 'label': 'Father'},
      {'id': 4, 'label': 'Mother'},
      {'id': 5, 'label': 'Uncle'},
      {'id': 6, 'label': 'Aunt'},
      {'id': 7, 'label': 'Me'},
      {'id': 8, 'label': 'Cousin'},
    ],
    'edges': [
      {'from': 1, 'to': 2}, // Grandpa - Grandma
      {'from': 1, 'to': 3}, // Grandpa - Father
      {'from': 2, 'to': 4}, // Grandma - Mother
      {'from': 3, 'to': 7}, // Father - Me
      {'from': 3, 'to': 5}, // Father - Uncle
      {'from': 4, 'to': 6}, // Mother - Aunt
      {'from': 5, 'to': 8}, // Uncle - Cousin
    ]
  };

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    var edges = familyJson['edges']!;
    for (var element in edges) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    }

    builder
      ..siblingSeparation = 100
      ..levelSeparation = 150
      ..subtreeSeparation = 150
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT;
  }

  TransformationController viewerTransformerController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: InteractiveViewer(
              onInteractionStart: (details) {
                print('Start: ${details}');
              },
              onInteractionEnd: (details) {
                print('End: ${details}');
              },
              onInteractionUpdate: (details) {
                print('Update: ${details}');
                viewerTransformerController.value = Matrix4.identity()
                  ..translate(
                      details.localFocalPoint.dx, details.localFocalPoint.dy)
                  ..translate(
                      -details.localFocalPoint.dx, -details.localFocalPoint.dy);
              },
              scaleEnabled: false,
              transformationController: viewerTransformerController,
              constrained: false,
              boundaryMargin: EdgeInsets.all(50),
              minScale: 0.01,
              maxScale: 5.6,
              // set interaction so have panning only by 100px
              child: GraphView(
                graph: graph,
                algorithm: BuchheimWalkerAlgorithm(
                  builder,
                  TreeEdgeRenderer(builder),
                ),
                paint: Paint()
                  ..color = Colors.black
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  var nodeId = node.key!.value as int?;
                  var nodes = familyJson['nodes']!;
                  var nodeData =
                      nodes.firstWhere((element) => element['id'] == nodeId);
                  return rectangleWidget(nodeData['label'] as String?);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rectangleWidget(String? label) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Text('$label'),
      ),
    );
  }
}
