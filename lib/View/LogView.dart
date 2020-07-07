import 'package:flutter/material.dart';
import 'package:geofence_test/Notifier/MainNotifier.dart';
import 'package:geolocation/geolocation.dart';
import 'package:provider/provider.dart';

class LogView extends StatefulWidget {
  @override
  _LogViewState createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  Widget build(BuildContext context) {
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
        body: Column(
          children: <Widget>[
            Divider(
              height: 10,
            ),
            Text("Location Logs"),
            Divider(
              height: 10,
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
                leading: Text("Z"),
                subtitle: getLatLong(data.locationList[i].result.locations[0]),
                title: Text("Geofence Distance".toString()),
              ),
            );
          },
        );
      })),
    );
  }

  Widget getLatLong(Location location) {
    var lat = location.latitude.toStringAsFixed(4);
    var lng = location.longitude.toStringAsFixed(4);
    return Text("Lat:$lat,Lng:$lng");
  }
}
