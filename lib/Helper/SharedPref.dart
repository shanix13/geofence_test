import 'package:geofence_test/Model/GeofenceModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;

class SharedPref {
  String _geofenceList = "geofenceList";

  SharedPreferences prefs;

  Future<void> getSettings() async {
    prefs = await SharedPreferences.getInstance();
    var temp = prefs.getStringList(_geofenceList);
    try {
      cfg.Config.geofenceList = new GeofenceModel();
      cfg.Config.geofenceList.lat = double.parse(temp[0]);
      cfg.Config.geofenceList.lng = double.parse(temp[1]);
      cfg.Config.geofenceList.rad = double.parse(temp[2]);
      cfg.Config.geofenceList.ssid = temp[3];
      cfg.Config.geofenceList.name = temp[4];
    } catch (e) {
      cfg.Config.geofenceList = new GeofenceModel();
      cfg.Config.geofenceList.lat = 0;
      cfg.Config.geofenceList.lng = 0;
      cfg.Config.geofenceList.rad = 10;
      cfg.Config.geofenceList.ssid = "";
      cfg.Config.geofenceList.name = "";
      print(e);
    }
  }

  Future<void> saveGeofence(
      double lat, double lng, double radius, String ssid, String name) async {
    prefs = await SharedPreferences.getInstance();
    List<String> temp = new List();
    temp.add(lat.toString());
    temp.add(lng.toString());
    temp.add(radius.toString());
    temp.add(ssid);
    temp.add(name);

    cfg.Config.geofenceList.lat = double.parse(temp[0]);
    cfg.Config.geofenceList.lng = double.parse(temp[1]);
    cfg.Config.geofenceList.rad = double.parse(temp[2]);
    cfg.Config.geofenceList.ssid = temp[3];
    cfg.Config.geofenceList.name = temp[4];

    await prefs.setStringList(_geofenceList, temp);
  }
}
