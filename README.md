<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Easy Software Package

The Easy Software package is a collection of widgets and utilities that simplify software development in Flutter. These widgets encompass a variety of functionalities, such as tables, maps, charts, and more. The package is designed to be easy to use and integrate into existing projects.

## Features

- **Tables**: The `ScrollableTable` and `PaginatedTable` widget allows you to display data with customization options such as header style, row height, and editable columns.

- **Interactive Maps**: The `TiledMap` widget provides an interactive map with support for customizable markers, polygons, geofences and polylines. You can choose between map providers like Google Maps and OpenStreetMap.

- **Charts**: The `DonutChart` widget allows you to visualize data in an interactive and customizable donut chart. You can display indicators associated with each chart element.

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  easy_software: ^0.0.1
```

Then, import the package in your Dart files:

```dart
import 'package:easy_software/easy_software.dart';
```

## Usage

Here are some examples of how you can use the widgets provided by this package:

### Scrollable Tables

```dart
ScrollableTable(
  data: myData,
  headers: myHeaders,
  rowElementsBuilder: (item) {
    return [
      Text(item.name),
      Text(item.email),
      Text(item.phone),
    ];
  },
)
```

### Interactive Maps

```dart
TiledMap(
  geoFences: myGeoFences,
  geoPolygons: myGeoPolygons,
  markers: myMarkers,
  polylines: myPolylines,
  provider: TiledMapProvider.google,
)
```

### Donut Charts

```dart
DonutChart(
  data: myChartData,
  showIndicators: true,
  vertical: false,
)
```

## Contributions

Contributions are welcome. If you encounter any issues or have an improvement request, please create an issue or submit a pull request.

## License

This package is licensed under the [MIT License](LICENSE).