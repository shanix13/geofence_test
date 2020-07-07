import 'package:geofence_test/Model/GeofenceModel.dart';

class Config {
  static int currentIndex = 0;
  static int selectedIndex = 0;
  static bool trackingStart = false;
  static Map<String, GeofenceModel> geofenceList = new Map();
  static double geoFenceRadius = 10;
}

enum geoStat { enter, exit, dwell, inside, outside }
