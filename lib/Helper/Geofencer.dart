import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geofence_test/Helper/WifiHelper.dart';
import 'package:geofence_test/Model/GeofenceModel.dart';
import 'package:geofence_test/Model/LocationData.dart';
import 'package:geofence_test/Notifier/MainNotifier.dart';
import 'package:geolocation/geolocation.dart';
import 'package:geolocator/geolocator.dart' as geoLoc;
import 'package:provider/provider.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;

class Geofencer {
  MainNotifier provider;
  WifiHelper wifi;
  StreamSubscription<LocationResult> _subscription;
  int _subscriptionStartedTimestamp;

  void initialize(BuildContext context) {
    provider = Provider.of<MainNotifier>(context, listen: false);
    wifi = new WifiHelper();
    wifi.initialize();
    startTracking();
  }

  startTracking() {
    if (cfg.Config.trackingStart) {
      // cfg.Config.trackingStart = false;

      // _subscription.cancel();
      // _subscription = null;
      // _subscriptionStartedTimestamp = null;
    } else {
      cfg.Config.trackingStart = true;

      _subscriptionStartedTimestamp = new DateTime.now().millisecondsSinceEpoch;
      _subscription = Geolocation.locationUpdates(
        accuracy: LocationAccuracy.best,
        displacementFilter: 0.0,
        inBackground: false,
      ).listen((result) async {
        final location = new LocationData(
          result: result,
          elapsedTimeSeconds: (new DateTime.now().millisecondsSinceEpoch -
                  _subscriptionStartedTimestamp) ~/
              1000,
        );
        var ssid = await wifi.getSSID();
        cfg.Config.currentLat = location.result.locations[0].latitude;
        cfg.Config.currentLng = location.result.locations[0].longitude;

        var geoVal = await checkGeofence(location.result.locations[0].latitude,
            location.result.locations[0].longitude, ssid);
        provider.setUserLocations(location, geoVal, ssid);
      });

      _subscription.onDone(() {
        cfg.Config.trackingStart = false;
      });
    }
  }

  Future<List> checkGeofence(
      double curretLat, double currentLng, String ssid) async {
    cfg.geoStat geoStat;
    var lat = cfg.Config.geofenceList.lat;
    var lng = cfg.Config.geofenceList.lng;
    double distanceFromFence = await geoLoc.Geolocator()
        .distanceBetween(lat, lng, curretLat, currentLng);

    if (distanceFromFence <= cfg.Config.geofenceList.rad ||
        ssid == cfg.Config.geofenceList.ssid) {
      geoStat = cfg.geoStat.inside;
    } else {
      geoStat = cfg.geoStat.outside;
    }
    cfg.Config.currenGeoStat = geoStat;
    return [distanceFromFence, geoStat];
  }
}
