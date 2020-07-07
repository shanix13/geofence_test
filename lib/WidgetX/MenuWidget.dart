import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;

class MenuWidget extends StatelessWidget {
  final Function updateBody;

  MenuWidget(this.updateBody);

  @override
  Widget build(BuildContext context) {
    double fontSize = 10;

    return Container(
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
          color: Colors.teal[400],
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.5))
          ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
              gap: 20,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              //curve: Curves.easeIn,
              duration: Duration(milliseconds: 300),
              tabBackgroundColor: Colors.indigoAccent,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Dashboard',
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize),
                ),
                GButton(
                  icon: Icons.data_usage,
                  text: 'Logs',
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize),
                ),
              ],
              selectedIndex: cfg.Config.selectedIndex,
              onTabChange: (index) {
                updateBody(index);
              }),
        ),
      ),
    );
  }
}
