import 'package:flutter/material.dart';
import 'package:geofence_test/Model/LocationData.dart';

class MainNotifier with ChangeNotifier {
  String latLong = "";
  List<LocationData> locationList = [];

  // void setLatLong(String _latLong) {
  //   latLong = _latLong;
  //   notify();
  // }

  void setUserLocations(
      LocationData _latLong, List<dynamic> geoVal, String ssid) {
    if (locationList.length > 50) {
      locationList.clear();
    }
    _latLong.dateTime = DateTime.now();
    _latLong.distance = geoVal[0];
    _latLong.geoStat = geoVal[1];
    _latLong.ssid = ssid;
    locationList.insert(0, _latLong);
    notify();
  }

  void notify() {
    notifyListeners();
  }
}
