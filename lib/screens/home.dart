import 'package:flutter/material.dart';
import 'package:flutter_custom_graph/models/data_model.dart';
import 'package:flutter_custom_graph/painters/graph_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DataPoint> data = [
    DataPoint(0, 0),
    DataPoint(1, 2),
    DataPoint(2, 3),
    DataPoint(3, 4),
    DataPoint(4, 5),
    DataPoint(5, 3.5),
    DataPoint(6, 4.2),
    DataPoint(7, 5.6),
    DataPoint(8, 6.1),
    DataPoint(9, 6.9),
    DataPoint(10, 7.5),
    DataPoint(11, 6.8),
    DataPoint(12, 7.2),
    DataPoint(13, 8.0),
    DataPoint(14, 7.8),
    DataPoint(15, 8.5),
    DataPoint(16, 9.0),
    DataPoint(17, 9.3),
    DataPoint(18, 9.8),
    DataPoint(19, 9.5),
    DataPoint(20, 10.0),
    DataPoint(21, 9.6),
    DataPoint(22, 9.2),
    DataPoint(23, 8.9),
    DataPoint(24, 9.4),
    DataPoint(25, 10.5),
    DataPoint(26, 10.8),
    DataPoint(27, 11.2),
    DataPoint(28, 11.0),
    DataPoint(29, 11.5),
    DataPoint(30, 12.0),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              width: width,
              height: height * 0.25,
              child: CustomPaint(
                painter: GraphPainter(
                  // data: [0.1, 0.3, 0.5, 0.2, 0.8, 0.4, 0.9, 0.6, 0.7, 0.2, 0.95],
                  data: data,
                  yTickInterval: 2,
                  xTickInterval: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
