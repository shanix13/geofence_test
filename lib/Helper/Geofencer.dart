import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geofence_test/Model/LocationData.dart';
import 'package:geofence_test/Notifier/MainNotifier.dart';
import 'package:geolocation/geolocation.dart';
import 'package:provider/provider.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;

class Geofencer {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MainNotifier provider;
  //List<_LocationData> _locations = [];
  StreamSubscription<LocationResult> _subscription;
  int _subscriptionStartedTimestamp;
  // bool _isTracking = false;

  void initialize(BuildContext context) {
    provider = Provider.of<MainNotifier>(context, listen: false);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);

    _onTogglePressed();
  }

  _onTogglePressed() {
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
      ).listen((result) {
        final location = new LocationData(
          result: result,
          elapsedTimeSeconds: (new DateTime.now().millisecondsSinceEpoch -
                  _subscriptionStartedTimestamp) ~/
              1000,
        );
        provider.setUserLocations(location);
      });

      _subscription.onDone(() {
        cfg.Config.trackingStart = false;
      });
    }
  }

  void getUserLocation() {}

  void addGeoFence() {}

  void startListen() {}

  void scheduleNotification(String title, String subtitle) {
    Future.delayed(Duration(seconds: 5)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.Max,
          priority: Priority.High,
          ticker: 'ticker');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          0, title, subtitle, platformChannelSpecifics,
          payload: 'item x');
    });
  }
}
