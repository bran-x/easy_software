import 'package:easy_software/easy_software.dart';
import 'package:easy_software/map/models.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class GoogleMapExample extends StatefulWidget {
  const GoogleMapExample({super.key});

  @override
  State<GoogleMapExample> createState() => _GoogleMapExampleState();
}

class _GoogleMapExampleState extends State<GoogleMapExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: TiledMap(
          geoFences: fences,
          geoPolygons: polygons,
          markers: markers,
          polylines: polyLines,
          provider: TiledMapProvider.google,
        ),
      ),
    );
  }
}

List<GeoFence> fences = [
  GeoFence(
    name: 'Geocerca 1',
    latitude: -11.9402089,
    longitude: -77.0679478,
    radius: 100,
    color: Colors.red,
  ),
  GeoFence(
    name: 'Geocerca 2',
    latitude: -12.079671,
    longitude: -77.057627,
    radius: 100,
    color: Colors.blue,
  ),
];

List<GeoPolygon> polygons = [
  GeoPolygon(
    name: 'Poligono 1',
    points: [
      const LatLng(-12.102815, -77.051334),
      const LatLng(-12.099048, -77.050785),
      const LatLng(-12.098823, -77.049573),
      const LatLng(-12.098586, -77.049369),
      const LatLng(-12.100707, -77.038192),
      const LatLng(-12.103464, -77.038779),
      const LatLng(-12.101880, -77.046154),
      const LatLng(-12.102762, -77.046466),
    ],
    color: Colors.yellow,
    borderColor: Colors.black,
    isDotted: true,
  ),
];

List<GeoMarker> markers = [
  GeoMarker(
    name: 'Marcador',
    point: const LatLng(-12.090685, -77.055293),
    builder: (context) {
      return const Icon(
        Icons.location_on,
        color: Colors.red,
        size: 36,
      );
    },
  ),
  GeoMarker(
    name: 'Usuario',
    point: const LatLng(-12.094002, -77.064622),
    width: 36,
    height: 36,
    builder: (context) {
      return InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuario'),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 24,
          ),
        ),
      );
    },
  ),
];

List<GeoPolyLine> polyLines = [
  GeoPolyLine(
    name: 'Polilinea',
    points: [
      const LatLng(-12.077711, -77.086946),
      const LatLng(-12.073263, -77.099563),
      const LatLng(-12.062603, -77.095443),
      const LatLng(-12.055217, -77.056562),
    ],
    color: Colors.green,
    width: 5,
  ),
  GeoPolyLine(
    name: 'Polilinea 2',
    points: [
      const LatLng(-12.067807, -77.032444),
      const LatLng(-12.092147, -77.022573),
      const LatLng(-12.092063, -77.033731),
    ],
    color: Colors.redAccent,
    width: 3,
  ),
];
