import 'package:flutter/material.dart';

mixin StyleX {
  var workerTextStyle =
      TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);

  var normalTextStyle =
      TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400);
  var tabTextStyle =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500);
  var infoValueTextStyle =
      TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500);
  var dropDownStyle =
      TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);

  Widget iconButtonX({String label, IconData icon, Function callback}) {
    return InkWell(
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: normalTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Icon(icon)
          ],
        ),
        onTap: () {
          callback();
        });
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

  Widget textContainer(
      String lable, Function editComplete, TextEditingController controller) {
    return Container(
      width: 200,
      child: Card(
        color: Colors.white,
        child: TextFormField(
          onEditingComplete: editComplete(),
          decoration: new InputDecoration(
              labelText: lable,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal))),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: TextStyle(color: Colors.black),
          controller: controller,
        ),
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
}
