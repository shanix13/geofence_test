import 'package:geofence_test/Model/GeofenceModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;

class SharedPref {
  String _geofenceList = "geofenceList";

  SharedPreferences prefs;

  Future<void> getSettings() async {
    prefs = await SharedPreferences.getInstance();
    var temp = prefs.getStringList(_geofenceList);
    cfg.Config.geofenceList = new GeofenceModel();
    cfg.Config.geofenceList.lat = double.parse(temp[0]);
    cfg.Config.geofenceList.lng = double.parse(temp[1]);
    cfg.Config.geofenceList.radius = double.parse(temp[2]);
    cfg.Config.geofenceList.ssid = temp[3];
    cfg.Config.geofenceList.name = temp[4];
  }

  Future<void> saveGeofence(
      double lat, double lng, double radius, String ssid, String name) async {
    prefs = await SharedPreferences.getInstance();
    List<String> value = new List();
    value.add(lat.toString());
    value.add(lng.toString());
    value.add(radius.toString());
    value.add(ssid);
    value.add(name);

    await prefs.setStringList(_geofenceList, value);
  }
}
