import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  String title='Title';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var scaffold = new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(),
      /// Builders let you pass context
      /// from your *current* build method
      /// Directly to children returned in this build method
      ///
      /// The 'builder' property accepts a callback
      /// which can be treated exactly as a 'build' method on any
      /// widget
      floatingActionButton: new Builder(builder: (context) {
        return new FloatingActionButton(onPressed: () {
          Scaffold.of(context).showSnackBar(
            new SnackBar(
              backgroundColor: Colors.blue,
              content: new Text('SnackBar'),
            ),
          );
        });
      }),
    );
    return MaterialApp(
      home: scaffold,
    );
  }
}
