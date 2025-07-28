import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_custom_graph/models/data_model.dart';

class GraphPainter extends CustomPainter {
  final List<List<DataPoint>> lines; // List of line datasets
  final List<Color> lineColors;
  final int? xInterval;
  final double? yInterval;
  final bool showRightAxis;

  GraphPainter({
    required this.lines,
    required this.lineColors,
    this.xInterval,
    this.yInterval,
    this.showRightAxis = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintAxis = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    final textStyle = const TextStyle(color: Colors.black, fontSize: 10);
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Flatten all points to find global min/max
    final allPoints = lines.expand((line) => line).toList();

    double minX = allPoints.map((e) => e.x).reduce(min);
    double maxX = allPoints.map((e) => e.x).reduce(max);
    double minY = allPoints.map((e) => e.y).reduce(min);
    double maxY = allPoints.map((e) => e.y).reduce(max);

    // Padding
    const double leftPadding = 40;
    const double rightPadding = 40;
    const double bottomPadding = 20;
    const double topPadding = 10;

    final chartWidth = size.width - leftPadding - rightPadding;
    final chartHeight = size.height - topPadding - bottomPadding;

    // Draw Y-Axis left
    canvas.drawLine(
      Offset(leftPadding, topPadding),
      Offset(leftPadding, size.height - bottomPadding),
      paintAxis,
    );

    // Optional right Y-Axis
    if (showRightAxis) {
      canvas.drawLine(
        Offset(size.width - rightPadding, topPadding),
        Offset(size.width - rightPadding, size.height - bottomPadding),
        paintAxis,
      );
    }

    // Draw X-Axis
    canvas.drawLine(
      Offset(leftPadding, size.height - bottomPadding),
      Offset(size.width - rightPadding, size.height - bottomPadding),
      paintAxis,
    );

    // Plot multiple lines
    for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      final path = Path();
      final line = lines[lineIndex];
      final color = lineColors[lineIndex % lineColors.length];

      final paintLine = Paint()
        ..color = color
        ..strokeWidth = 3.0
        ..style = PaintingStyle.stroke;

      for (int i = 0; i < line.length; i++) {
        final point = line[i];
        double normX = (point.x - minX) / (maxX - minX);
        double normY = (point.y - minY) / (maxY - minY);

        double x = leftPadding + normX * chartWidth;
        double y = topPadding + (1 - normY) * chartHeight;

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paintLine);
    }

    // Draw Y-axis labels (left)
    final yTick = yInterval ?? (maxY - minY) / 5;
    for (double val = minY; val <= maxY; val += yTick) {
      double norm = (val - minY) / (maxY - minY);
      double y = topPadding + (1 - norm) * chartHeight;

      // Left
      textPainter.text = TextSpan(
        text: val.toStringAsFixed(1),
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(leftPadding - textPainter.width - 4, y - textPainter.height / 2),
      );

      // Optional tick
      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(leftPadding + 4, y),
        paintAxis,
      );

      // Right axis mirror
      if (showRightAxis) {
        textPainter.paint(
          canvas,
          Offset(size.width - rightPadding + 4, y - textPainter.height / 2),
        );
        canvas.drawLine(
          Offset(size.width - rightPadding, y),
          Offset(size.width - rightPadding - 4, y),
          paintAxis,
        );
      }
    }

    // Draw X-axis labels
    final xTick =
        xInterval ??
        ((maxX - minX) ~/ lines[0].length).clamp(1, double.infinity).toInt();
    for (double val = minX; val <= maxX; val += xTick) {
      double norm = (val - minX) / (maxX - minX);
      double x = leftPadding + norm * chartWidth;

      textPainter.text = TextSpan(
        text: val.toStringAsFixed(0),
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - bottomPadding + 4),
      );

      // Tick
      canvas.drawLine(
        Offset(x, size.height - bottomPadding),
        Offset(x, size.height - bottomPadding - 4),
        paintAxis,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.lines != lines ||
        oldDelegate.lineColors != lineColors ||
        oldDelegate.xInterval != xInterval ||
        oldDelegate.yInterval != yInterval ||
        oldDelegate.showRightAxis != showRightAxis;
  }
}
