import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geofence_test/Helper/Geofencer.dart';
import 'package:geofence_test/Helper/SharedPref.dart';
import 'package:geofence_test/Helper/WifiHelper.dart';
import 'package:geofence_test/View/SettingView.dart';

class MainController {
  Geofencer _geofencer;

  Future<void> initialize(BuildContext context) async {
    _geofencer = new Geofencer();
    _geofencer.initialize(context);
  }

  Future<void> getConfiguration() async {
    SharedPref sp = new SharedPref();
    await sp.getSettings();
  }

  void openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingView()),
    );
  }
}
