import 'package:flutter/cupertino.dart';
import 'package:geofence_test/Helper/Geofencer.dart';

class MainController {
  Geofencer _geofencer;
  void initialize(BuildContext context) {
    _geofencer = new Geofencer();
    _geofencer.initialize(context);
    _geofencer.addGeoFence();
    _geofencer.startListen();
  }

  void getLocation() {
    _geofencer.getUserLocation();
  }
}
