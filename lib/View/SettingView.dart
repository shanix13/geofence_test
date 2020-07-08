import 'package:flutter/material.dart';
import 'package:geofence_test/Helper/DialogX.dart';
import 'package:geofence_test/WidgetX/MapLocation.dart';
import 'package:geofence_test/Helper/SharedPref.dart';
import 'package:geofence_test/Helper/WifiHelper.dart';
import 'package:geofence_test/WidgetX/StyleX.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> with StyleX {
  TextEditingController teSSID = new TextEditingController();
  TextEditingController teName = new TextEditingController();
  TextEditingController teLocation = new TextEditingController();
  double lat = 0;
  double lng = 0;
  double radius = 0;
  DialogX dx = new DialogX();

  @override
  void initState() {
    super.initState();
    teName.text = cfg.Config.geofenceList.name;
    teSSID.text = cfg.Config.geofenceList.ssid;
    lat = cfg.Config.geofenceList.lat;
    lng = cfg.Config.geofenceList.lng;
    radius = cfg.Config.geofenceList.rad;
    teLocation.text = "$lat,$lng\nRadius($radius meter)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => saveConfig(),
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(children: <Widget>[
        Divider(),
        ListTile(
          title: Text("Enter GeoFence Name"),
          dense: true,
          subtitle: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  textEdit(
                    teName,
                  )
                ],
              )),
          leading: Column(
            children: <Widget>[
              Icon(Icons.info, color: Colors.grey),
            ],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text("Enter Wifi SSID or Get"),
          dense: true,
          subtitle: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  textEdit(
                    teSSID,
                  )
                ],
              )),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                iconButtonX(
                    label: "GET SSID",
                    icon: Icons.wifi_tethering,
                    callback: getDeviceSSID),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          leading: Column(
            children: <Widget>[
              Icon(Icons.wifi, color: Colors.grey),
            ],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text("Lat Long"),
          dense: true,
          subtitle: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  textEdit(
                    teLocation,
                  )
                ],
              )),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                iconButtonX(
                    label: "OPEN MAP",
                    icon: Icons.map,
                    callback: navigateToMap),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          leading: Column(
            children: <Widget>[
              Icon(Icons.pin_drop, color: Colors.grey),
            ],
          ),
          onTap: () {},
        ),
      ]),
    );
  }

  Future<void> getDeviceSSID() async {
    WifiHelper wifi = new WifiHelper();
    teSSID.text = await wifi.getSSID();
  }

  Future<void> saveConfig() async {
    SharedPref sp = new SharedPref();
    await sp.saveGeofence(lat, lng, radius, teSSID.text, teName.text);
    dx.showToastBottom(context, "Geofence Saved");
  }

  navigateToMap() async {
    List<String> result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapLocation()),
    );
    if (result != null) {
      var selectedlocation = result.length == 0 ? "" : result[0];
      var _latLng = selectedlocation.split(",");
      var _radius = result[1].toString();

      lat = double.parse(_latLng[0]);
      lng = double.parse(_latLng[1]);
      radius = double.parse(_radius);

      teLocation.text =
          _latLng[0] + "," + _latLng[1] + "\nRadius($_radius meter)";
    }
  }
}
