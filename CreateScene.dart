// Import the necessary packages
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

// Create a stateful widget
class MyScene extends StatefulWidget {
  @override
  _MySceneState createState() => _MySceneState();
}

class _MySceneState extends State<MyScene> {
  ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return ArCoreView(
      onArCoreViewCreated: _onArCoreViewCreated,
    );
  }

  // Function to create the 3D scene
  _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addSphere(arCoreController);
  }

  // Function to add a sphere to the scene
  _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.blue,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.2,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: math.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
} 

// Call the widget in the main function
void main() => runApp(MaterialApp(home: MyScene()));