import 'package:flutter/material.dart';
import 'package:geofence_test/Controller/MainController.dart';
import 'package:geofence_test/Notifier/MainNotifier.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainController mc;

  @override
  void initState() {
    super.initState();
    mc = new MainController();
    mc.initialize(context);
  }

// Your latitude is 5.360698640375153 and longitude 100.31398247927427
  @override
  Widget build(BuildContext context) {
    return Consumer<MainNotifier>(builder: (_, data, child) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Icon(Icons.gps_not_fixed),
              SizedBox(
                width: 20,
              ),
              Text("GeoX")
            ],
          ),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Divider(
                  height: 200,
                ),
                Text(
                  data.latLong,
                  style: TextStyle(color: Colors.red),
                ),
                RaisedButton(
                  child: Text("Request Permissions"),
                  onPressed: () {
                    mc.getLocation();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
