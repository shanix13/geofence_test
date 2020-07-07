import 'package:flutter/material.dart';
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
          title: Text("Enter Wifi SSID"),
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
            width: 60,
            child: Column(
              children: <Widget>[
                Text("Save"),
                Icon(Icons.save),
              ],
            ),
          ),
          leading: Column(
            children: <Widget>[
              Icon(Icons.wifi, color: Colors.grey),
              Icon(Icons.wifi, color: Colors.grey),
            ],
          ),
          onTap: () {},
        ),
      ]),
    );
  }
}
