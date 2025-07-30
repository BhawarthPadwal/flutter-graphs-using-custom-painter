import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_featured_graph/features/home/data/models/dart_points_model.dart';

class LineGraphPainterWidget extends CustomPainter {
  final List<List<DataPointsModel>> lines;
  final List<Color> linesColors;
  final int xInterval;
  final int yInterval;
  final double graphLeftPadding;
  final double graphRightPadding;
  final double graphTopPadding;
  final double graphBottomPadding;
  final DataPointsModel? toolTipPoint;
  final int? toolTipLineIndex;
  final double minYValue;
  final double maxYValue;
  final double zoomScale;

  LineGraphPainterWidget({
    required this.lines,
    required this.linesColors,
    this.xInterval = 5,
    this.yInterval = 2,
    this.graphLeftPadding = 20,
    this.graphRightPadding = 20,
    this.graphTopPadding = 20,
    this.graphBottomPadding = 20,
    this.toolTipPoint,
    this.toolTipLineIndex,
    this.minYValue = 0,
    this.maxYValue = double.infinity,
    this.zoomScale = 1.0,
  });

  late double minX, maxX, minY, maxY;
  late double chartWidth, chartHeight;
  late int xTick, yTick;
  late TextStyle textStyle;
  late TextPainter textPainter;
  late Paint axisPaint;

  void getDimensions(Size size) {
    final allPoints = lines.expand((line) => line).toList();
    minX = allPoints.map((e) => e.x).reduce(min);
    maxX = allPoints.map((e) => e.x).reduce(max);
    minY = allPoints.map((e) => e.y).reduce(min);
    maxY = allPoints.map((e) => e.y).reduce(max);

    chartWidth = size.width - graphLeftPadding - graphRightPadding;
    chartHeight = size.height - graphTopPadding - graphBottomPadding;
  }

  void customizeText() {
    textStyle = TextStyle(color: Colors.black, fontSize: 12);
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
  }

  void drawAxis(Canvas canvas, Size size) {
    axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // y - axis
    canvas.drawLine(Offset(20, 20), Offset(20, size.height - 20), axisPaint);

    // x - axis
    canvas.drawLine(
      Offset(20, size.height - 20),
      Offset(size.width - 20, size.height - 20),
      axisPaint,
    );

    // right y - axis
    canvas.drawLine(
      Offset(size.width - 20, size.height - 20),
      Offset(size.width - 20, 20),
      axisPaint,
    );
  }

  void drawGrids(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
    // xTick =
    //     xInterval ??
    //     ((maxX - minX) ~/ lines[0].length).clamp(1, double.infinity).toInt();
    xTick = xInterval;
    for (double val = minX; val <= maxX; val += xTick) {
      double norm = (val - minX) / (maxX - minX);
      double x = graphLeftPadding + norm * chartWidth;

      canvas.drawLine(
        Offset(x, graphTopPadding),
        Offset(x, size.height - graphBottomPadding),
        gridPaint,
      );
    }

    // yTick =
    //     yInterval ??
    //     ((maxY - minY) ~/ lines[0].length).clamp(1, double.infinity).toInt();
    yTick = yInterval;
    for (double val = minY; val <= maxY; val += yTick) {
      double norm = (val - minY) / (maxY - minY);
      double y = graphTopPadding + (1 - norm) * chartHeight;

      canvas.drawLine(
        Offset(graphLeftPadding, y),
        Offset(size.width - graphRightPadding, y),
        gridPaint,
      );
    }
  }

  void plotAllLines(Canvas canvas) {
    for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      final path = Path();
      final line = lines[lineIndex];
      final color = linesColors[lineIndex % linesColors.length];

      final linePaint = Paint()
        ..color = color
        ..strokeWidth = 3.0
        ..style = PaintingStyle.stroke;

      for (int i = 0; i < line.length; i++) {
        final point = line[i];
        double normX =
            (point.x - minX) /
            (maxX - minX); // e.g.  (40 - 0) / (10 - 0) => 40 / 10 => 4
        double normY = (point.y - minY) / (maxY - minY);

        double x = graphLeftPadding + normX * chartWidth;
        double y = graphTopPadding + (1 - normY) * chartHeight;

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, linePaint);
    }
  }

  void drawTickLabels(Canvas canvas, Size size) {
    for (double val = minY; val <= maxY; val += yTick) {
      double norm = (val - minY) / (maxY - minY);
      double y = graphTopPadding + (1 - norm) * chartHeight;

      textPainter.text = TextSpan(
        text: val.toStringAsFixed(0),
        style: textStyle,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          graphLeftPadding - textPainter.width - 4,
          y - textPainter.height / 2,
        ),
      );

      canvas.drawLine(
        Offset(graphLeftPadding - 2, y),
        Offset(graphLeftPadding + 2, y),
        axisPaint,
      );

      textPainter.paint(
        canvas,
        Offset(size.width - graphRightPadding + 4, y - textPainter.height / 2),
      );

      canvas.drawLine(
        Offset(size.width - graphRightPadding - 2, y),
        Offset(size.width - graphRightPadding + 2, y),
        axisPaint,
      );
    }

    // Ticks for x - axis
    for (double val = minX; val <= maxX; val += xTick) {
      double norm = (val - minX) / (maxX - minX);
      double x = graphLeftPadding + norm * chartWidth;

      textPainter.text = TextSpan(
        text: val.toStringAsFixed(0),
        style: textStyle,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - graphBottomPadding + 4),
      );

      // Tick
      canvas.drawLine(
        Offset(x, size.height - graphBottomPadding),
        Offset(x, size.height - graphBottomPadding - 4),
        axisPaint,
      );
    }
  }

  void showToolKit(Canvas canvas) {
    if (toolTipPoint != null && toolTipLineIndex != null) {
      final toolTipPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      final toolTipBorderPaint = Paint()
        ..color = linesColors[toolTipLineIndex! % linesColors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      double normX = (toolTipPoint!.x - minX) / (maxX - minX);
      double normY = (toolTipPoint!.y - minY) / (maxY - minY);
      double x = graphLeftPadding + normX * chartWidth;
      double y = graphTopPadding + (1 - normY) * chartHeight;

      canvas.drawCircle(Offset(x, y), 4, toolTipPaint);
      canvas.drawCircle(Offset(x, y), 3, toolTipBorderPaint);

      String toolTipText =
          '(${toolTipPoint!.x.toStringAsFixed(1)}, ${toolTipPoint!.y.toStringAsFixed(1)})';
      textPainter.text = TextSpan(
        text: toolTipText,
        style: TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();

      final toolTipRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(x, y - 25),
          width: textPainter.width + 16,
          height: textPainter.height + 8,
        ),
        Radius.circular(4),
      );

      canvas.drawRRect(toolTipRect, toolTipPaint);
      canvas.drawRRect(toolTipRect, toolTipBorderPaint);

      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - 25 - textPainter.height / 2),
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    getDimensions(size);
    customizeText();
    drawAxis(canvas, size);
    drawGrids(canvas, size);
    plotAllLines(canvas);
    drawTickLabels(canvas, size);
    showToolKit(canvas);
  }

  @override
  bool shouldRepaint(covariant LineGraphPainterWidget oldDelegate) {
    return oldDelegate.toolTipPoint != toolTipPoint;
  }
}
