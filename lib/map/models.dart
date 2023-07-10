import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class GeoFence {
  String name;
  String? description;
  double latitude;
  double longitude;
  double radius;
  Color color;
  GeoFence({
    required this.name,
    this.description,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.color,
  });
}

class GeoPolygon {
  String name;
  String? description;
  List<LatLng> points;
  Color color;
  Color borderColor;
  bool isDotted;

  GeoPolygon({
    required this.name,
    this.description,
    this.isDotted = false,
    required this.points,
    required this.color,
    required this.borderColor,
  });
}

class GeoPolyLine {
  String name;
  String? description;
  List<LatLng> points;
  Color color;
  double width;

  GeoPolyLine({
    required this.name,
    this.description,
    required this.points,
    required this.color,
    this.width = 2,
  });
}

class GeoMarker {
  String name;
  String? description;
  LatLng point;
  double width;
  double height;
  Widget Function(BuildContext) builder;

  GeoMarker({
    required this.name,
    this.description,
    required this.point,
    required this.builder,
    this.width = 50,
    this.height = 50,
  });
}
