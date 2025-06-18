import 'package:easy_software/map/models.dart';
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
    this.onTap,
    this.controller,
    this.center,
    this.zoom,
    this.maxZoom = 21.0,
  });

  final List<GeoFence>? geoFences;
  final List<GeoPolygon>? geoPolygons;
  final List<GeoMarker>? markers;
  final List<GeoPolyLine>? polylines;
  final TiledMapProvider provider;
  final MapController? controller;
  final LatLng? center;
  final double? zoom;
  final double maxZoom;

  final void Function(TapPosition position, LatLng latlng)? onTap;
  @override
  State<TiledMap> createState() => _TiledMapState();
}

class _TiledMapState extends State<TiledMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.controller,
      options: MapOptions(
        initialCenter: widget.center ?? const LatLng(50.5, 30.51),
        initialZoom: widget.zoom ?? 13.0,
        maxZoom: widget.maxZoom,
        onTap: widget.onTap,
      ),
      children: [
        TileLayer(
          urlTemplate: urlTemplate,
          userAgentPackageName: 'com.example.easy_software',
          maxZoom: widget.maxZoom,
        ),
        if (widget.provider == TiledMapProvider.arcgisSatellital)
          TileLayer(
            urlTemplate: urlNamesLayer,
            userAgentPackageName: 'com.example.easy_software',
            maxZoom: widget.maxZoom,
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
                  pattern: polygon.isDotted
                      ? const StrokePattern.dotted()
                      : const StrokePattern.solid(),
                ),
            ],
          ),
        if (widget.polylines != null)
          PolylineLayer(
            polylines: [
              for (var polyline in widget.polylines!)
                Polyline(
                  points: polyline.points,
                  color: polyline.color,
                  strokeWidth: polyline.width,
                ),
            ],
          ),
        if (widget.markers != null)
          MarkerLayer(
            markers: [
              for (var marker in widget.markers!)
                Marker(
                  point: marker.point,
                  child: marker.builder(context),
                  width: marker.width,
                  height: marker.height,
                ),
            ],
          ),
      ],
    );
  }

  String get urlNamesLayer {
    switch (widget.provider) {
      case TiledMapProvider.google:
        return '';
      case TiledMapProvider.openStreetMap:
        return '';
      case TiledMapProvider.arcgisSatellital:
        return 'https://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/{z}/{y}/{x}';
      default:
        return '';
    }
  }

  String get urlTemplate {
    switch (widget.provider) {
      case TiledMapProvider.google:
        return 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
      case TiledMapProvider.openStreetMap:
        return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
      case TiledMapProvider.arcgisSatellital:
        return 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}';
      default:
        return 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
    }
  }
}

enum TiledMapProvider {
  google,
  openStreetMap,
  arcgisSatellital,
}
