import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';

class LocationData {
  LocationData(
      {@required this.result,
      @required this.elapsedTimeSeconds,
      this.dateTime});

  final LocationResult result;
  final int elapsedTimeSeconds;
  DateTime dateTime;
}
