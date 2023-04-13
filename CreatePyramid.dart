import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart' as vector;

class Pyramid extends StatelessWidget {
  final double size;
  final Color color;

  Pyramid({this.size = 100, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PyramidPainter(size, color),
    );
  }
}

class _PyramidPainter extends CustomPainter {
  final double size;
  final Color color;

  _PyramidPainter(this.size, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(this.size, 0)
      ..lineTo(this.size / 2, this.size / 2)
      ..lineTo(0, 0)
      ..moveTo(this.size / 2, this.size / 2)
      ..lineTo(this.size / 2, -this.size / 2)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);

    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.002)
      ..rotateX(vector.radians(45))
      ..rotateY(vector.radians(45));

    canvas.save();
    canvas.translate(this.size / 2, this.size / 2);
    canvas.transform(matrix.storage);
    canvas.translate(-this.size / 2, -this.size / 2);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_PyramidPainter oldDelegate) {
    return oldDelegate.size != size || oldDelegate.color != color;
  }
}
