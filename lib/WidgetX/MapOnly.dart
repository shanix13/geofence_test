import 'package:flutter/material.dart';
import 'package:geofence_test/WidgetX/StyleX.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;

class MapOnly extends StatefulWidget {
  final bool enableMarkerSelect;
  final double height;
  MapOnly({Key key, this.height, this.enableMarkerSelect}) : super(key: key);
  @override
  _MapOnlyState createState() => _MapOnlyState();
}

class _MapOnlyState extends State<MapOnly> with StyleX {
  GoogleMapController mapController;

  double radius;
  LatLng _center;
  Marker marker1;
  Color geofenceColor;
  Set<Circle> circles;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    geofenceColor = Colors.redAccent.withOpacity(0.5);
    radius = cfg.Config.geofenceList.rad;
    _center = LatLng(cfg.Config.geofenceList.lat, cfg.Config.geofenceList.lng);
  }

  @override
  Widget build(BuildContext context) {
    if (cfg.Config.currenGeoStat == cfg.geoStat.inside) {
      geofenceColor = Colors.greenAccent.withOpacity(0.5);
    } else if (cfg.Config.currenGeoStat == cfg.geoStat.outside) {
      geofenceColor = Colors.redAccent.withOpacity(0.5);
    }
    drawCircle(cfg.Config.geofenceList.lat, cfg.Config.geofenceList.lng);
    return Container(
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: _onMapCreated,
        onTap: (latLng) {
          if (widget.enableMarkerSelect == false) {
            return;
          }
        },
        circles: circles,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  drawCircle(double markerLat, double markerLong) {
    circles = Set.from([
      Circle(
        circleId: CircleId("ID"),
        center: LatLng(markerLat, markerLong),
        strokeWidth: 1,
        fillColor: geofenceColor,
        radius: radius,
      )
    ]);
  }
}
