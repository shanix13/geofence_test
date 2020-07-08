import 'package:flutter/material.dart';
import 'package:geofence_test/Helper/WifiHelper.dart';
import 'package:geofence_test/WidgetX/StyleX.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> with StyleX {
  TextEditingController teSSID = new TextEditingController();

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
        actions: <Widget>[],
      ),
      body: ListView(children: <Widget>[
        Divider(),
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
                  width: 20,
                ),
                iconButtonX(
                    label: "SAVE", icon: Icons.save, callback: getDeviceSSID),
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
      ]),
    );
  }

  Future<void> getDeviceSSID() async {
    WifiHelper wifi = new WifiHelper();
    teSSID.text = await wifi.getSSID();
  }

  Widget iconButtonX({String label, IconData icon, Function callback}) {
    return InkWell(
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: normalTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Icon(icon)
          ],
        ),
        onTap: () {
          callback();
        });
  }
}
