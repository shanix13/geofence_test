import 'package:flutter/material.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;
import 'package:geofence_test/Notifier/MainNotifier.dart';
import 'package:geolocation/geolocation.dart';
import 'package:provider/provider.dart';

class LogView extends StatefulWidget {
  @override
  _LogViewState createState() => _LogViewState();
}

TextStyle styleNormal = new TextStyle(fontSize: 12);
TextStyle styleH1 = new TextStyle(fontSize: 15);

class _LogViewState extends State<LogView> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Icon(Icons.data_usage),
              SizedBox(
                width: 20,
              ),
              Text("Location Logs")
            ],
          ),
          backgroundColor: Colors.teal,
        ),
        body: Column(
          children: <Widget>[
            Divider(
              height: 20,
            ),
            Divider(
              height: 15,
            ),
            locationsList()
          ],
        ));
  }

  Widget locationsList() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height / 1.3,
      width: MediaQuery.of(context).size.width,
      child: Scrollbar(child: Consumer<MainNotifier>(builder: (_, data, child) {
        return ListView.builder(
          itemCount: data.locationList.length,
          itemBuilder: (context, i) {
            var time = data.locationList[i].dateTime
                .toString()
                .split(" ")[1]
                .split('.')[0];

            return Card(
              color: Colors.white,
              child: ListTile(
                  trailing: Container(
                    child: Column(
                      children: <Widget>[
                        Chip(
                          backgroundColor: Colors.indigo[400],
                          label: Text(
                            time,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  leading: geoStatWidget(data.locationList[i].geoStat),
                  subtitle:
                      getLatLong(data.locationList[i].result.locations[0]),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Distance:${data.locationList[i].distance.toStringAsFixed(4)} meter",
                        style: styleNormal,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "SSID:${data.locationList[i].ssid}",
                        style: styleNormal,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
            );
          },
        );
      })),
    );
  }

  Widget geoStatWidget(cfg.geoStat geoStat) {
    String label = "";
    Color bColor;
    if (geoStat == cfg.geoStat.inside) {
      label = "INSIDE";
      bColor = Colors.green;
    } else if (geoStat == cfg.geoStat.outside) {
      label = "OUTSIDE";
      bColor = Colors.red;
    }
    return Chip(
      backgroundColor: bColor,
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget getLatLong(Location location) {
    var lat = location.latitude.toStringAsFixed(4);
    var lng = location.longitude.toStringAsFixed(4);
    // print("Lat:$lat,Lng:$lng");
    return Text("Lat:$lat,Lng:$lng");
  }
}
