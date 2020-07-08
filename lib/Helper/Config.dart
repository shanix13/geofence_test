import 'package:geofence_test/Model/GeofenceModel.dart';

class Config {
  static int currentIndex = 0;
  static int selectedIndex = 0;
  static bool trackingStart = false;
  //TODO add list for multi geo
  //static List<GeofenceModel> geofenceList = new List();
  static GeofenceModel geofenceList = new GeofenceModel();
  static double geoFenceRadius = 10;
}

enum geoStat { enter, exit, dwell, inside, outside }
