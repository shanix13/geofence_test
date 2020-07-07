import 'package:flutter/services.dart';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';

class WifiHelper {
  WifiInfoWrapper _wifiObject;

  Future<void> initialize() async {
    WifiInfoWrapper wifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}

    _wifiObject = wifiObject;
  }

  String getSSID() {
    var ssid = _wifiObject.ssid.replaceAll("\"", "");
    return ssid;
  }
}
