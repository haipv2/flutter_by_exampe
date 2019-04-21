import 'package:flutter/material.dart';
import 'package:flutter_app_example/redux_firebase/models/app_state.dart';
import 'package:flutter_app_example/redux_firebase/pages/home_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app_example/redux_firebase/reducer/app_reducer.dart';
import 'package:redux_logging/redux_logging.dart';

void main() => runApp(new MusicParty());

class MusicParty extends StatelessWidget {
  String title = 'Me Suite'; // new
  @override
  Widget build(BuildContext context) {
    String title = 'MeSuite';
    //
    // Store is just a class that holds your apps State tree.
    // AppState is something that we will (but haven't yet) established
    final store = new Store<AppState>(
      // new
      appReducer, // new
      initialState: new AppState(), // new
      middleware: [new LoggingMiddleware.printer()], // new
    );

    return StoreProvider(
      store: store,
      child: new MaterialApp(
        // updated
        title: title, // new
        home: new HomePage(title), // new
      ),
    );
  }
}
