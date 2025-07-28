# Flutter Custom Graph

This Flutter project demonstrates how to create a custom graph using the `CustomPainter` widget. The application displays a line graph based on a predefined set of data points.

## Features

- **Custom Graph Rendering:** The graph is drawn using `CustomPainter`, providing full control over the visual representation.
- **Dynamic Data Points:** The graph is rendered based on a list of `DataPoint` objects, which can be easily modified or fetched from an external source.
- **Customizable Axes:** The X and Y axes are drawn with customizable tick intervals.
- **Responsive Layout:** The graph adapts to the screen size.

## Code Overview

- **`main.dart`**: The entry point of the application.
- **`app.dart`**: Sets up the `MaterialApp` and the initial route.
- **`screens/home.dart`**: The main screen of the application, which contains the `CustomPaint` widget for the graph.
- **`models/data_model.dart`**: Defines the `DataPoint` class for the graph data.
- **`painters/graph_painter.dart`**: Contains the `GraphPainter` class, which is responsible for drawing the graph.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](httpss://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](httpss://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](httpss://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
