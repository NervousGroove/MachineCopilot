import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class Cube extends StatelessWidget {
  final double size;
  final Color color;

  Cube({this.size = 50.0, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateX(math.pi / 4)
          ..rotateY(math.pi / 4),
        alignment: FractionalOffset.center,
        child: Container(
          width: size,
          height: size,
          color: color,
        ),
      ),
    );
  }
}

