import 'package:flutter/material.dart';
import 'package:geofence_test/Helper/GpsLocator.dart';
import 'package:geofence_test/WidgetX/StyleX.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;

class MapLocation extends StatefulWidget {
  final bool useGps;
  final String lat;
  final String long;

  MapLocation({Key key, this.useGps, this.lat, this.long}) : super(key: key);
  @override
  _MapLocationState createState() => _MapLocationState();
}

var markerLat = 5.416393;
var markerLong = 100.332680;
List<String> geofenceSetting;

class _MapLocationState extends State<MapLocation> with StyleX {
  GoogleMapController mapController;
  final teLocationController = TextEditingController();
  final teRadius = TextEditingController();
  double radius;
  LatLng _center;
  Marker marker1;
  Set<Circle> circles;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    geofenceSetting = new List<String>();
    teLocationController.text =
        "${markerLat.toStringAsFixed(4)},${markerLong.toStringAsFixed(4)}";

    radius = cfg.Config.geofenceList.rad;

    teRadius.text = radius.toString();
    _center = LatLng(cfg.Config.geofenceList.lat, cfg.Config.geofenceList.lng);
    marker1 = Marker(
        markerId: MarkerId("id1"),
        position: LatLng(markerLat, markerLong),
        icon: BitmapDescriptor.defaultMarker);

    geofenceSetting.add(teLocationController.text);
    geofenceSetting.add(radius.toString());
    drawCircle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('SELECT LOCATION'),
        backgroundColor: Colors.teal,
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Text("GPS"),
                  Icon(Icons.gps_fixed),
                ],
              ),
              onPressed: () => {getGpsLocation()},
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.grey,
            ),
            SizedBox(
              width: 20,
            ),
            RaisedButton(
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Text("USE THIS LOCATION"),
                  Icon(Icons.arrow_downward),
                ],
              ),
              onPressed: () => {Navigator.pop(context, geofenceSetting)},
              color: Colors.red,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.grey,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            textContainer("Lat,Long", getUserLocation, teLocationController),
            textContainer("Radius (meter)", radiusChanged, teRadius),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: _onMapCreated,
            onTap: (LatLng) {
              markerLat = LatLng.latitude;
              markerLong = LatLng.longitude;
              teLocationController.text =
                  "${markerLat.toStringAsFixed(4)},${markerLong.toStringAsFixed(4)}";
              geofenceSetting[0] = teLocationController.text;
              drawCircle();
              setState(() {
                marker1 = Marker(
                    markerId: MarkerId("id1"),
                    position: LatLng,
                    icon: BitmapDescriptor.defaultMarker);
              });
            },
            circles: circles,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: {marker1},
          ),
        ),
      ]),
    );
  }

  radiusChanged() {
    radius = double.parse(teRadius.text);
    geofenceSetting[1] = (radius.toString());

    drawCircle();
  }

  getUserLocation() {
    if (geofenceSetting.length > 0) {
      geofenceSetting[0] = teLocationController.text;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  drawCircle() {
    circles = Set.from([
      Circle(
        circleId: CircleId("ID"),
        center: LatLng(markerLat, markerLong),
        strokeWidth: 1,
        fillColor: Colors.blueAccent.withOpacity(0.5),
        radius: radius,
      )
    ]);
  }

  Future getGpsLocation() async {
    GpsLocator gps = new GpsLocator();
    var latLong = await gps.getLatLong();
    var _latLong = latLong.split(':');
    teLocationController.text = _latLong[0];
    setState(() {
      markerLat = double.parse(_latLong[0]);
      markerLong = double.parse(_latLong[1]);
      _center = LatLng(markerLat, markerLong);
      drawCircle();
      mapController.moveCamera(CameraUpdate.newLatLng(_center));

      marker1 = Marker(
          markerId: MarkerId("id1"),
          position: LatLng(markerLat, markerLong),
          icon: BitmapDescriptor.defaultMarker);
    });
  }
}
