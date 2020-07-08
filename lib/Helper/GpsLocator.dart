import 'package:geolocator/geolocator.dart';

class GpsLocator {
  Future ceheck() async {
    var isGpsEnabled = await Geolocator().isLocationServiceEnabled();
    return isGpsEnabled;
  }

  Future<String> getLatLong() async {
    Position position;
    var isEnabled = await ceheck();
    List<Placemark> placemarks;
    if (isEnabled) {
      try {
        final Geolocator geolocator = Geolocator()
          ..forceAndroidLocationManager = false;
        position = await geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        placemarks = await geolocator.placemarkFromCoordinates(
            position.latitude, position.longitude);
      } catch (Exception) {
        print(Exception);
        position = null;
      }

      var _lat = position.latitude.toString();
      var _long = position.longitude.toString();
      return _lat + ":" + _long;
    } else {
      return "5.416393:100.332680";
    }
  }
}
