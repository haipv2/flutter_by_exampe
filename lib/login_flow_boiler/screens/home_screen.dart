import 'package:flutter/material.dart';
import 'package:flutter_app_example/login_flow_boiler/app.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Suite'),
      ),
      body: new Center(
//        child: new Text(appState.user.displayName),
        child: new Text('appState.user.displayName'),
      ),
    );
  }
}
