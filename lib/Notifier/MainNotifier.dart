import 'package:flutter/material.dart';

class MainNotifier with ChangeNotifier {
  String latLong = "";

  void setLatLong(String _latLong) {
    latLong = _latLong;
    notify();
  }

  void notify() {
    notifyListeners();
  }
}
