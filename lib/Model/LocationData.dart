import 'package:flutter/material.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;
import 'package:geolocation/geolocation.dart';

class LocationData {
  LocationData(
      {@required this.result,
      @required this.elapsedTimeSeconds,
      this.distance,
      this.geoStat,
      this.ssid,
      this.dateTime});

  final LocationResult result;
  final int elapsedTimeSeconds;
  DateTime dateTime;
  double distance;
  String ssid;
  cfg.geoStat geoStat;
}
