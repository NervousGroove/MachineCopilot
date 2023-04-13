// Import the necessary libraries
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart' as vector;

// Define the 3D prism widget
class Prism3D extends StatefulWidget {
  @override
  _Prism3DState createState() => _Prism3DState();
}

class _Prism3DState extends State<Prism3D> {
  // Define the prism's vertices
  final List<vector.Vector3> _vertices = [
    vector.Vector3(-1, -1, -1),
    vector.Vector3(-1, -1, 1),
    vector.Vector3(-1, 1, -1),
    vector.Vector3(-1, 1, 1),
    vector.Vector3(1, -1, -1),
    vector.Vector3(1, -1, 1),
    vector.Vector3(1, 1, -1),
    vector.Vector3(1, 1, 1),
  ];

  // Define the prism's edges
  final List<List<int>> _edges = [
    [0, 1],
    [0, 2],
    [0, 4],
    [1, 3],
    [1, 5],
    [2, 3],
    [2, 6],
    [3, 7],
    [4, 5],
    [4, 6],
    [5, 7],
    [6, 7],
  ];

  // Define the prism's rotation
  vector.Vector3 _rotation = vector.Vector3.zero();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Rotate the prism on drag
      onPanUpdate: (details) {
        setState(() {
          _rotation += vector.Vector3(details.delta.dy, details.delta.dx, 0);
        });
      },
      child: CustomPaint(
        painter: _PrismPainter(_vertices, _edges, _rotation),
        size: Size.infinite,
      ),
    );
  }
}

// Define the prism painter
class _PrismPainter extends CustomPainter {
  final List<vector.Vector3> _vertices;
  final List<List<int>> _edges;
  final vector.Vector3 _rotation;

  _PrismPainter(this._vertices, this._edges, this._rotation);

  @override
  void paint(Canvas canvas, Size size) {
    // Define the center of the canvas
    final center = vector.Vector2(size.width / 2, size.height / 2);

    // Define the projection matrix
    final projection = vector.Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..setEntry(0, 0, center.y / center.x)
      ..setEntry(1, 1, 1.0)
      ..setEntry(2, 2, -1.0);

    // Define the rotation matrix
    final rotation = vector.Matrix4.rotationX(_rotation.x) *
        vector.Matrix4.rotationY(_rotation.y) *
        vector.Matrix4.rotationZ(_rotation.z);

    // Define the transformation matrix
    final transformation = projection * rotation;

    // Project and draw the vertices
    for (final vertex in _vertices) {
      final projected = vertex.clone()..applyMatrix4(transformation);
      final point = Offset(projected.x, projected.y) * 100 + center;
      canvas.drawCircle(point, 4, Paint()..color = Colors.white);
    }

    // Draw the edges
    for (final edge in _edges) {
      final p1 = _vertices[edge[0]].clone()..applyMatrix4(transformation);
      final p2 = _vertices[edge[1]].clone()..applyMatrix4(transformation);
      final point1 = Offset(p1.x, p1.y) * 100 + center;
      final point2 = Offset(p2.x, p2.y) * 100 + center;
      canvas.drawLine(point1, point2, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(_PrismPainter oldDelegate) => true;
} 

// Use the Prism3D widget in your app
