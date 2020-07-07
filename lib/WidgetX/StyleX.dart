import 'package:flutter/material.dart';

mixin StyleX {
  var workerTextStyle =
      TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);

  var infoTextStyle =
      TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400);
  var tabTextStyle =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500);
  var infoValueTextStyle =
      TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500);
  var dropDownStyle =
      TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);
}

Widget textEdit(TextEditingController controller, [double fontSize]) {
  fontSize = fontSize == null ? 14 : fontSize;
  return TextFormField(
    controller: controller,
    style: TextStyle(
      fontSize: fontSize / 1,
    ),
  );
}

Widget textEditBox(
    TextEditingController controller, String label, String label2,
    [double fontSize, bool isPassword = false]) {
  fontSize = fontSize == null ? 14 : fontSize;

  return TextFormField(
    validator: (value) {
      if (value.isEmpty) {
        return label2;
      }
      return null;
    },
    style: TextStyle(
      fontSize: fontSize / 1,
    ),
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(),
      labelText: label,
    ),
  );
}
