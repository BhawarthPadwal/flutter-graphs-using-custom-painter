import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_featured_graph/features/home/data/models/dart_points_model.dart';
import 'package:flutter_custom_featured_graph/features/home/presentation/widgets/line_graph_painter_widget.dart';
import 'package:flutter_custom_featured_graph/features/home/presentation/widgets/touch_lines_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DataPointsModel> data = [
    DataPointsModel(0, 0),
    DataPointsModel(1, 2),
    DataPointsModel(2, 3),
    DataPointsModel(3, 4),
    DataPointsModel(4, 5),
    DataPointsModel(5, 3.5),
    DataPointsModel(6, 4.2),
    DataPointsModel(7, 5.6),
    DataPointsModel(8, 6.1),
    DataPointsModel(9, 6.9),
    DataPointsModel(10, 7.5),
    DataPointsModel(11, 6.8),
    DataPointsModel(12, 7.2),
    DataPointsModel(13, 8.0),
    DataPointsModel(14, 7.8),
    DataPointsModel(15, 8.5),
    DataPointsModel(16, 9.0),
    DataPointsModel(17, 9.3),
    DataPointsModel(18, 9.8),
    DataPointsModel(19, 9.5),
    DataPointsModel(20, 10.0),
    DataPointsModel(21, 9.6),
    DataPointsModel(22, 9.2),
    DataPointsModel(23, 8.9),
    DataPointsModel(24, 9.4),
    DataPointsModel(25, 10.5),
    DataPointsModel(26, 10.8),
    DataPointsModel(27, 11.2),
    DataPointsModel(28, 11.0),
    DataPointsModel(29, 11.5),
    DataPointsModel(30, 12.0),
  ];

  final List<DataPointsModel> data2 = [
    DataPointsModel(0, 1),
    DataPointsModel(1, 2.5),
    DataPointsModel(2, 3.2),
    DataPointsModel(3, 3.8),
    DataPointsModel(4, 4.9),
    DataPointsModel(5, 4.0),
    DataPointsModel(6, 4.8),
    DataPointsModel(7, 6.0),
    DataPointsModel(8, 6.4),
    DataPointsModel(9, 6.0),
    DataPointsModel(10, 7.8),
    DataPointsModel(11, 7.0),
    DataPointsModel(12, 6.9),
    DataPointsModel(13, 7.5),
    DataPointsModel(14, 8.2),
    DataPointsModel(15, 7.9),
    DataPointsModel(16, 8.6),
    DataPointsModel(17, 9.1),
    DataPointsModel(18, 9.0),
    DataPointsModel(19, 9.7),
    DataPointsModel(20, 10.2),
    DataPointsModel(21, 10.0),
    DataPointsModel(22, 9.4),
    DataPointsModel(23, 8.7),
    DataPointsModel(24, 9.0),
    DataPointsModel(25, 9.8),
    DataPointsModel(26, 10.2),
    DataPointsModel(27, 10.5),
    DataPointsModel(28, 10.8),
    DataPointsModel(29, 11.3),
    DataPointsModel(30, 11.6),
  ];

  DataPointsModel? selectedPoint;
  int? selectedLineIndex;
  late double graphWidth;
  late double graphHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        graphWidth = MediaQuery.of(context).size.width - 40;
        graphHeight = MediaQuery.of(context).size.height * 0.6;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleTap(Offset localPosition, Size canvasSize) {
    const double tapThreshold = 50.0; // Increased for better touch detection

    double graphLeftPadding = 20;
    double graphRightPadding = 20;
    double graphTopPadding = 20;
    double graphBottomPadding = 20;

    // Check if the tap is within the graph bounds
    if (localPosition.dx < graphLeftPadding ||
        localPosition.dx > canvasSize.width - graphRightPadding ||
        localPosition.dy < graphTopPadding ||
        localPosition.dy > canvasSize.height - graphBottomPadding) {
      setState(() {
        selectedPoint = null;
        selectedLineIndex = null;
      });
      return;
    }

    final lines = [data, data2];
    final allPoints = lines.expand((e) => e).toList();
    final minX = allPoints.map((e) => e.x).reduce(min);
    final maxX = allPoints.map((e) => e.x).reduce(max);
    final minY = allPoints.map((e) => e.y).reduce(min);
    final maxY = allPoints.map((e) => e.y).reduce(max);

    final chartWidth = canvasSize.width - graphLeftPadding - graphRightPadding;
    final chartHeight =
        canvasSize.height - graphTopPadding - graphBottomPadding;

    DataPointsModel? closestPoint;
    int? closestLineIndex;
    double minDistance = double.infinity;

    // Find the closest point
    for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      for (final point in lines[lineIndex]) {
        double normX = (point.x - minX) / (maxX - minX);
        double normY = (point.y - minY) / (maxY - minY);

        double dx = graphLeftPadding + normX * chartWidth;
        double dy = graphTopPadding + (1 - normY) * chartHeight;

        double distance = (Offset(dx, dy) - localPosition).distance;
        if (distance < minDistance && distance < tapThreshold) {
          minDistance = distance;
          closestPoint = point;
          closestLineIndex = lineIndex;
        }
      }
    }

    setState(() {
      selectedPoint = closestPoint;
      selectedLineIndex = closestLineIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    graphWidth = width - 40;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          height: height * 0.35,
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onPanUpdate: (details) {
              _handleTap(details.localPosition, Size(width, height * 0.5));
            },
            onTapDown: (details) {
              _handleTap(details.localPosition, Size(width, height * 0.5));
            },
            onPanEnd: (_) {
              setState(() {
                selectedPoint = null;
                selectedLineIndex = null;
              });
            },
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(width, height * 0.5),
                  painter: LineGraphPainterWidget(
                    lines: [data, data2],
                    linesColors: [Colors.blueAccent, Colors.deepPurple],
                    toolTipPoint: selectedPoint,
                    toolTipLineIndex: selectedLineIndex,
                  ),
                ),
                if (selectedPoint != null)
                  CustomPaint(
                    size: Size(width, height * 0.5),
                    painter: TouchLinesPainter(
                      touchPoint: selectedPoint!,
                      color: Color.fromRGBO(128, 128, 128, 0.5),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
