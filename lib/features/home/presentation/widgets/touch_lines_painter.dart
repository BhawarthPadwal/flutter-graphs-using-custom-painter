import 'package:flutter/material.dart';
import 'package:flutter_custom_featured_graph/features/home/data/models/dart_points_model.dart';

class TouchLinesPainter extends CustomPainter {
  final DataPointsModel touchPoint;
  final Color color;

  TouchLinesPainter({required this.touchPoint, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double leftPadding = 20;
    const double rightPadding = 20;
    const double topPadding = 20;
    const double bottomPadding = 20;

    final chartWidth = size.width - leftPadding - rightPadding;

    // Get all possible points to find min/max
    final minX = 0.0;
    final maxX = 30.0; // Based on your data points

    // Calculate x position
    final normX = (touchPoint.x - minX) / (maxX - minX);
    final x = leftPadding + normX * chartWidth;

    // Draw vertical line
    canvas.drawLine(
      Offset(x, topPadding),
      Offset(x, size.height - bottomPadding),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant TouchLinesPainter oldDelegate) {
    return oldDelegate.touchPoint != touchPoint;
  }
}
