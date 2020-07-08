import 'package:geofence_test/Controller/MainController.dart';
import 'package:geofence_test/Helper/Config.dart' as cfg;
import 'package:flutter/material.dart';
import 'package:geofence_test/View/LogView.dart';
import 'package:geofence_test/View/MainView.dart';
import 'package:geofence_test/WidgetX/MenuWidget.dart';

class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> with WidgetsBindingObserver {
  static dynamic pages = [];
  MainController mc = new MainController();
  bool initialized = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getConfiguration();
    pages = [
      MainView(),
      LogView(),
    ];
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: initialized == false
            ? CircularProgressIndicator()
            : Scaffold(
                backgroundColor: Colors.grey[100],
                body: pages[cfg.Config.selectedIndex],
                bottomNavigationBar: MenuWidget(updateBody)));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  Future<void> getConfiguration() async {
    print("Get Configuration");
    await mc.getConfiguration();

    initialized = true;
    setState(() {});
  }

  void updateBody(int index) {
    cfg.Config.selectedIndex = index;
    setState(() {});
  }
}
