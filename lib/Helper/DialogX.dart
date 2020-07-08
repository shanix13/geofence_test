import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class DialogX {
  void showToastTop(BuildContext ctx, String message) {
    Flushbar(
      title: "INFO",
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      animationDuration: Duration(seconds: 1),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
    )..show(ctx);
  }

  void showToastBottom(BuildContext ctx, String message) {
    Flushbar(
      title: "INFO",
      flushbarPosition: FlushbarPosition.BOTTOM,
      message: message,
      animationDuration: Duration(seconds: 1),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
    )..show(ctx);
  }
}
