import 'package:easy_software/map/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TiledMap extends StatefulWidget {
  const TiledMap({
    super.key,
    this.geoFences,
    this.geoPolygons,
    this.markers,
    this.polylines,
    this.provider = TiledMapProvider.google,
  });

  final List<GeoFence>? geoFences;
  final List<GeoPolygon>? geoPolygons;
  final List<GeoMarker>? markers;
  final List<GeoPolyLine>? polylines;
  final TiledMapProvider provider;
  @override
  State<TiledMap> createState() => _TiledMapState();
}

class _TiledMapState extends State<TiledMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: const LatLng(-12.046374, -77.042793),
        zoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: urlTemplate,
          userAgentPackageName: 'com.example.easy_software',
        ),
        if (widget.geoFences != null)
          CircleLayer(
            circles: [
              for (var fence in widget.geoFences!)
                CircleMarker(
                  point: LatLng(fence.latitude, fence.longitude),
                  color: fence.color.withOpacity(0.5),
                  borderColor: fence.color,
                  borderStrokeWidth: 2,
                  radius: fence.radius,
                  useRadiusInMeter: true,
                ),
            ],
          ),
        if (widget.geoPolygons != null)
          PolygonLayer(
            polygonCulling: true,
            polygons: [
              for (var polygon in widget.geoPolygons!)
                Polygon(
                  points: polygon.points,
                  color: polygon.color.withOpacity(0.5),
                  borderColor: polygon.borderColor,
                  borderStrokeWidth: 2,
                  isFilled: true,
                  isDotted: polygon.isDotted,
                ),
            ],
          ),
        if (widget.markers != null)
          MarkerLayer(
            markers: [
              for (var marker in widget.markers!)
                Marker(
                  point: marker.point,
                  builder: marker.builder,
                  width: marker.width,
                  height: marker.height,
                ),
            ],
          ),
        if (widget.polylines != null)
          PolylineLayer(
            polylineCulling: true,
            polylines: [
              for (var polyline in widget.polylines!)
                Polyline(
                  points: polyline.points,
                  color: polyline.color,
                  strokeWidth: polyline.width,
                ),
            ],
          ),
      ],
    );
  }

  String get urlTemplate {
    switch (widget.provider) {
      case TiledMapProvider.google:
        return 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
      case TiledMapProvider.openStreetMap:
        return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
      default:
        return 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
    }
  }
}

enum TiledMapProvider {
  google,
  openStreetMap,
}
