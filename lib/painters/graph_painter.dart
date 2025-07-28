// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_graph/models/data_model.dart';

// class GraphPainter extends CustomPainter {
//   final List<DataPoint> data;

//   GraphPainter({required this.data});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paintLine = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke;

//     final paintAxis = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 1.0;

//     final textStyle = TextStyle(color: Colors.black, fontSize: 10);
//     final textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     double minX = data.map((e) => e.x).reduce(min);
//     double maxX = data.map((e) => e.x).reduce(max);
//     double minY = data.map((e) => e.y).reduce(min);
//     double maxY = data.map((e) => e.y).reduce(max);

//     double chartWidth = size.width;
//     double chartHeight = size.height;

//     // Apply padding to make the graph readable
//     double paddingLeft = 20;
//     double paddingBottom = 30;
//     double paddingTop = 10;
//     double paddingRight = 10;

//     double drawableWidth = chartWidth - paddingLeft - paddingRight;
//     double drawableHeight = chartHeight - paddingTop - paddingBottom;

//     // Draw X and Y axes
//     Offset origin = Offset(paddingLeft, paddingTop + drawableHeight);
//     canvas.drawLine(
//       origin,
//       Offset(paddingLeft, paddingTop),
//       paintAxis,
//     ); // Y Axis
//     canvas.drawLine(
//       origin,
//       Offset(paddingLeft + drawableWidth, origin.dy),
//       paintAxis,
//     ); // X Axis

//     // -------- Y TICKS --------
//     int yTicks = 5;
//     double yRange = maxY - minY;
//     num yInterval = _getNiceInterval(yRange / yTicks);

//     num adjustedMinY = (minY / yInterval).floor() * yInterval;
//     num adjustedMaxY = (maxY / yInterval).ceil() * yInterval;

//     for (
//       num yValue = adjustedMinY;
//       yValue <= adjustedMaxY;
//       yValue += yInterval
//     ) {
//       double normalizedY =
//           (yValue - adjustedMinY) / (adjustedMaxY - adjustedMinY);
//       double y = origin.dy - normalizedY * drawableHeight;

//       textPainter.text = TextSpan(
//         text: yValue.toStringAsFixed(0),
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(paddingLeft - textPainter.width - 5, y - textPainter.height / 2),
//       );

//       canvas.drawLine(
//         Offset(paddingLeft - 3, y),
//         Offset(paddingLeft, y),
//         paintAxis,
//       );
//     }

//     // -------- X TICKS --------
//     int xTicks = min(data.length, 8);
//     double xRange = maxX - minX;
//     num xInterval = _getNiceInterval(xRange / xTicks);
//     num adjustedMinX = (minX / xInterval).floor() * xInterval;
//     num adjustedMaxX = (maxX / xInterval).ceil() * xInterval;

//     for (
//       num xValue = adjustedMinX;
//       xValue <= adjustedMaxX;
//       xValue += xInterval
//     ) {
//       double normalizedX =
//           (xValue - adjustedMinX) / (adjustedMaxX - adjustedMinX);
//       double x = paddingLeft + normalizedX * drawableWidth;

//       textPainter.text = TextSpan(
//         text: xValue.toStringAsFixed(0),
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(x - textPainter.width / 2, origin.dy + 4),
//       );

//       canvas.drawLine(
//         Offset(x, origin.dy),
//         Offset(x, origin.dy - 4),
//         paintAxis,
//       );
//     }

//     // -------- DRAW LINE GRAPH --------
//     Path path = Path();
//     for (int i = 0; i < data.length; i++) {
//       final point = data[i];

//       double normX = (point.x - adjustedMinX) / (adjustedMaxX - adjustedMinX);
//       double normY = (point.y - adjustedMinY) / (adjustedMaxY - adjustedMinY);

//       double x = paddingLeft + normX * drawableWidth;
//       double y = origin.dy - normY * drawableHeight;

//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }

//     canvas.drawPath(path, paintLine);
//   }

//   num _getNiceInterval(double rawInterval) {
//     final exp = pow(10, (log(rawInterval) / ln10).floorToDouble());
//     final fraction = rawInterval / exp;

//     if (fraction < 1.5) return 1 * exp;
//     if (fraction < 3) return 2 * exp;
//     if (fraction < 7) return 5 * exp;
//     return 10 * exp;
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_graph/models/data_model.dart';

// class GraphPainter extends CustomPainter {
//   final List<DataPoint> data;

//   GraphPainter({required this.data});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paintLine = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke;

//     final paintAxis = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 1.0;

//     final textStyle = TextStyle(color: Colors.black, fontSize: 10);
//     final textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     double minX = data.map((e) => e.x).reduce(min);
//     double maxX = data.map((e) => e.x).reduce(max);
//     double minY = data.map((e) => e.y).reduce(min);
//     double maxY = data.map((e) => e.y).reduce(max);

//     double chartWidth = size.width;
//     double chartHeight = size.height;

//     // Apply padding to make the graph readable
//     double paddingLeft = 20;
//     double paddingBottom = 30;
//     double paddingTop = 10;
//     double paddingRight = 10;

//     double drawableWidth = chartWidth - paddingLeft - paddingRight;
//     double drawableHeight = chartHeight - paddingTop - paddingBottom;

//     // Draw X and Y axes
//     Offset origin = Offset(paddingLeft, paddingTop + drawableHeight);
//     canvas.drawLine(
//       origin,
//       Offset(paddingLeft, paddingTop),
//       paintAxis,
//     ); // Y Axis
//     canvas.drawLine(
//       origin,
//       Offset(paddingLeft + drawableWidth, origin.dy),
//       paintAxis,
//     ); // X Axis

//     // -------- Y TICKS --------
//     int yTicks = 5;
//     double yRange = maxY - minY;
//     num yInterval = _getNiceInterval(yRange / yTicks);

//     num adjustedMinY = (minY / yInterval).floor() * yInterval;
//     num adjustedMaxY = (maxY / yInterval).ceil() * yInterval;

//     for (
//       num yValue = adjustedMinY;
//       yValue <= adjustedMaxY;
//       yValue += yInterval
//     ) {
//       double normalizedY =
//           (yValue - adjustedMinY) / (adjustedMaxY - adjustedMinY);
//       double y = origin.dy - normalizedY * drawableHeight;

//       textPainter.text = TextSpan(
//         text: yValue.toStringAsFixed(0),
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(paddingLeft - textPainter.width - 5, y - textPainter.height / 2),
//       );

//       canvas.drawLine(
//         Offset(paddingLeft - 3, y),
//         Offset(paddingLeft, y),
//         paintAxis,
//       );
//     }

//     // -------- X TICKS (Manual Interval) --------
//     num xInterval = 5; // <<< Manual interval value
//     num adjustedMinX = (minX / xInterval).floor() * xInterval;
//     num adjustedMaxX = (maxX / xInterval).ceil() * xInterval;

//     for (
//       num xValue = adjustedMinX;
//       xValue <= adjustedMaxX;
//       xValue += xInterval
//     ) {
//       double normalizedX =
//           (xValue - adjustedMinX) / (adjustedMaxX - adjustedMinX);
//       double x = paddingLeft + normalizedX * drawableWidth;

//       textPainter.text = TextSpan(
//         text: xValue.toStringAsFixed(0),
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(x - textPainter.width / 2, origin.dy + 4),
//       );

//       canvas.drawLine(
//         Offset(x, origin.dy),
//         Offset(x, origin.dy - 4),
//         paintAxis,
//       );
//     }

//     // -------- DRAW LINE GRAPH --------
//     Path path = Path();
//     for (int i = 0; i < data.length; i++) {
//       final point = data[i];

//       double normX = (point.x - adjustedMinX) / (adjustedMaxX - adjustedMinX);
//       double normY = (point.y - adjustedMinY) / (adjustedMaxY - adjustedMinY);

//       double x = paddingLeft + normX * drawableWidth;
//       double y = origin.dy - normY * drawableHeight;

//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }

//     canvas.drawPath(path, paintLine);
//   }

//   num _getNiceInterval(double rawInterval) {
//     final exp = pow(10, (log(rawInterval) / ln10).floorToDouble());
//     final fraction = rawInterval / exp;

//     if (fraction < 1.5) return 1 * exp;
//     if (fraction < 3) return 2 * exp;
//     if (fraction < 7) return 5 * exp;
//     return 10 * exp;
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_graph/models/data_model.dart';

// class GraphPainter extends CustomPainter {
//   final List<DataPoint> data;
//   final double? xInterval;
//   final double? yInterval;
//   final double padding = 24.0;

//   GraphPainter({required this.data, this.xInterval, this.yInterval});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paintLine = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke;

//     final paintAxis = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 1.0;

//     final textStyle = TextStyle(color: Colors.black, fontSize: 10);
//     final textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     // Determine min and max
//     double minX = data.map((e) => e.x).reduce(min);
//     double maxX = data.map((e) => e.x).reduce(max);
//     double minY = data.map((e) => e.y).reduce(min);
//     double maxY = data.map((e) => e.y).reduce(max);

//     // Expand to nearest interval
//     double xStep = xInterval ?? _autoInterval(minX, maxX, 5);
//     double yStep = yInterval ?? _autoInterval(minY, maxY, 5);
//     minX = (minX / xStep).floor() * xStep;
//     maxX = (maxX / xStep).ceil() * xStep;
//     minY = (minY / yStep).floor() * yStep;
//     maxY = (maxY / yStep).ceil() * yStep;

//     double chartWidth = size.width - padding * 1.5;
//     double chartHeight = size.height - padding;

//     // Draw axes
//     Offset origin = Offset(padding, chartHeight);
//     canvas.drawLine(origin, Offset(padding, 0), paintAxis);
//     canvas.drawLine(origin, Offset(size.width, chartHeight), paintAxis);

//     // Draw Y labels and ticks
//     for (double yVal = minY; yVal <= maxY; yVal += yStep) {
//       double normY = (yVal - minY) / (maxY - minY);
//       double y = chartHeight - (normY * chartHeight);

//       // Tick mark
//       canvas.drawLine(Offset(padding - 4, y), Offset(padding, y), paintAxis);

//       // Label
//       textPainter.text = TextSpan(
//         text: yVal.toStringAsFixed(0),
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(padding - textPainter.width - 6, y - textPainter.height / 2),
//       );
//     }

//     // Draw X labels and ticks
//     for (double xVal = minX; xVal <= maxX; xVal += xStep) {
//       double normX = (xVal - minX) / (maxX - minX);
//       double x = padding + (normX * chartWidth);

//       // Tick mark
//       canvas.drawLine(
//         Offset(x, chartHeight),
//         Offset(x, chartHeight + 4),
//         paintAxis,
//       );

//       // Label
//       textPainter.text = TextSpan(
//         text: xVal.toStringAsFixed(0),
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(x - textPainter.width / 2, chartHeight + 4),
//       );
//     }

//     // Draw Line Graph
//     Path path = Path();
//     for (int i = 0; i < data.length; i++) {
//       final point = data[i];
//       double normX = (point.x - minX) / (maxX - minX);
//       double normY = (point.y - minY) / (maxY - minY);

//       double x = padding + (normX * chartWidth);
//       double y = chartHeight - (normY * chartHeight);

//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }

//     canvas.drawPath(path, paintLine);
//   }

//   double _autoInterval(double minVal, double maxVal, int targetTicks) {
//     double range = maxVal - minVal;
//     double rawInterval = range / targetTicks;
//     double magnitude = pow(10, log(rawInterval) ~/ ln10).toDouble();
//     double norm = rawInterval / magnitude;

//     if (norm < 1.5) return 1 * magnitude;
//     if (norm < 3) return 2 * magnitude;
//     if (norm < 7) return 5 * magnitude;
//     return 10 * magnitude;
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_custom_graph/models/data_model.dart';

class GraphPainter extends CustomPainter {
  final List<DataPoint> data;
  final int xTickInterval;
  final double yTickInterval;
  final bool showRightYAxis;

  GraphPainter({
    required this.data,
    this.xTickInterval = 1,
    this.yTickInterval = 1.0,
    this.showRightYAxis = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paddingLeft = 40.0;
    final paddingBottom = 25.0;
    final paddingRight = showRightYAxis ? 40.0 : 10.0;
    final paddingTop = 20.0;

    final chartWidth = size.width - paddingLeft - paddingRight;
    final chartHeight = size.height - paddingTop - paddingBottom;

    final paintLine = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final paintAxis = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    final textStyle = TextStyle(color: Colors.black, fontSize: 10);
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    double minX = data.map((e) => e.x).reduce(min);
    double maxX = data.map((e) => e.x).reduce(max);
    double minY = data.map((e) => e.y).reduce(min);
    double maxY = data.map((e) => e.y).reduce(max);

    // Draw axis lines
    final origin = Offset(paddingLeft, size.height - paddingBottom);
    canvas.drawLine(
      origin,
      Offset(paddingLeft, paddingTop),
      paintAxis,
    ); // Left Y-axis
    canvas.drawLine(
      origin,
      Offset(size.width - paddingRight, size.height - paddingBottom),
      paintAxis,
    ); // X-axis

    if (showRightYAxis) {
      canvas.drawLine(
        Offset(size.width - paddingRight, size.height - paddingBottom),
        Offset(size.width - paddingRight, paddingTop),
        paintAxis,
      );
    }

    // Draw Y-axis labels and ticks
    for (double yValue = minY; yValue <= maxY; yValue += yTickInterval) {
      double normalizedY = (yValue - minY) / (maxY - minY);
      double y = size.height - paddingBottom - (normalizedY * chartHeight);

      final label = yValue.toStringAsFixed(1);
      textPainter.text = TextSpan(text: label, style: textStyle);
      textPainter.layout();

      // Left Y-axis label
      textPainter.paint(
        canvas,
        Offset(paddingLeft - textPainter.width - 4, y - textPainter.height / 2),
      );
      canvas.drawLine(
        Offset(paddingLeft, y),
        Offset(paddingLeft + 4, y),
        paintAxis,
      );

      // Right Y-axis label (if enabled)
      if (showRightYAxis) {
        textPainter.paint(
          canvas,
          Offset(size.width - paddingRight + 4, y - textPainter.height / 2),
        );
        canvas.drawLine(
          Offset(size.width - paddingRight - 4, y),
          Offset(size.width - paddingRight, y),
          paintAxis,
        );
      }
    }

    // Draw X-axis labels and ticks
    for (int i = 0; i < data.length; i += xTickInterval) {
      final point = data[i];
      double normalizedX = (point.x - minX) / (maxX - minX);
      double x = paddingLeft + normalizedX * chartWidth;

      final label = point.x.toStringAsFixed(0);
      textPainter.text = TextSpan(text: label, style: textStyle);
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - paddingBottom + 4),
      );
      canvas.drawLine(
        Offset(x, size.height - paddingBottom),
        Offset(x, size.height - paddingBottom - 4),
        paintAxis,
      );
    }

    // Draw graph path
    final path = Path();
    for (int i = 0; i < data.length; i++) {
      final point = data[i];
      double normalizedX = (point.x - minX) / (maxX - minX);
      double normalizedY = (point.y - minY) / (maxY - minY);

      double x = paddingLeft + normalizedX * chartWidth;
      double y = size.height - paddingBottom - normalizedY * chartHeight;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.xTickInterval != xTickInterval ||
        oldDelegate.yTickInterval != yTickInterval ||
        oldDelegate.showRightYAxis != showRightYAxis;
  }
}
