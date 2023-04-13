// Import the necessary libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class MyARObject extends StatefulWidget {
  @override
  _MyARObjectState createState() => _MyARObjectState();
}

class _MyARObjectState extends State<MyARObject> {
  ArCoreController arCoreController;
  
  // Define the texture path
  final String texturePath = "assets/my_texture.png";

  @override
  Widget build(BuildContext context) {
    return ArCoreView(
      onArCoreViewCreated: _onArCoreViewCreated,
      enableTapRecognizer: true,
    );
  }

  _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addObject();
  }

  _addObject() async {
    final ByteData textureBytes = await rootBundle.load(texturePath);
    final ArCoreMaterial material = ArCoreMaterial(
      color: Colors.white,
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final ArCoreSphere sphere = ArCoreSphere(
      materials: [material],
      radius: 0.2,
    );
    final ArCoreNode node = ArCoreNode(
      shape: sphere,
      position: math.Vector3(0, 0, -1.5),
    );
    arCoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
