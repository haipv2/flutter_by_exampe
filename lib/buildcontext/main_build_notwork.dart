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
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Container(),

        /// Scaffold doesn't exist in this context here
        /// because the context thats passed into 'build'
        /// refers to the Widget 'above' this one in the tree,
        /// and the Scaffold doesn't exist above this exact build method
        ///
        /// This will throw an error:
        /// 'Scaffold.of() called with a context that does not contain a Scaffold.'
        floatingActionButton: new FloatingActionButton(onPressed: () {
          print(context.hashCode);
          Scaffold.of(context).showSnackBar(
            new SnackBar(
              content: new Text('SnackBar'),
            ),
          );
        }));
  }
}
