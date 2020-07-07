import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geofence_test/Helper/Geofencer.dart';
import 'package:geofence_test/Helper/WifiHelper.dart';
import 'package:geofence_test/View/SettingView.dart';

class MainController {
  Geofencer _geofencer;

  void initialize(BuildContext context) {
    _geofencer = new Geofencer();
    _geofencer.initialize(context);
    _geofencer.addGeoFence();
  }

  void getLocation() {
    _geofencer.getUserLocation();
  }

  void openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingView()),
    );
  }
}
