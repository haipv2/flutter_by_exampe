import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_example/login_flow_boiler/states/app_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppStateContainer extends StatefulWidget {
  // Your apps state is managed by the container
  final AppState state;

  // This widget is simply the root of the tree,
  // so it has to have a child!
  final Widget child;

  AppStateContainer({
    @required this.child,
    this.state,
  });

  // This creates a method on the AppState that's just like 'of'
  // On MediaQueries, Theme, etc
  // This is the secret to accessing your AppState all over your app
  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  _AppStateContainerState createState() => new _AppStateContainerState();


}

class _AppStateContainerState extends State<AppStateContainer> {
  // Just padding the state through so we don't have to
  // manipulate it with widget.state.
  AppState state;

  // This is used to sign into Google, not Firebase.
  GoogleSignInAccount googleUser;
  // This class handles signing into Google.
  // It comes from the Firebase plugin.
  final googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    // You'll almost certainly want to do some logic
    // in InitState of your AppStateContainer. In this example, we'll eventually
    // write the methods to check the local state
    // for existing users and all that.
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new AppState.loading();
      // fake some config loading
//      startCountdown();
      // Call a separate function because you can't use
      // async functionality in initState()
      initUser();
    }
  }

  // So the WidgetTree is actually
  // AppStateContainer --> InheritedStateContainer --> The rest of your app.
  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  // If all goes well, when you launch the app
  // you'll see a loading spinner for 2 seconds
  // Then the HomeScreen main view will appear
  Future<Null> startCountdown() async {
    const timeOut = const Duration(seconds: 2);
    new Timer(timeOut, () {
      setState(() => state.isLoading = false);
    });
  }

  // All new:
  // This method is called on start up no matter what.
  Future<Null> initUser() async {
    // First, check if a user exists.
    googleUser = await _ensureLoggedInOnStartUp();
    // If the user is null, we aren't loading anyhting
    // because there isn't anything to load.
    // This will force the homepage to navigate to the auth page.
    if (googleUser == null) {
      setState(() {
        state.isLoading = false;
      });
    } else {
      // Do some other stuff, handle later.
    }
  }

  Future<GoogleSignInAccount> _ensureLoggedInOnStartUp() async {
    // That class has a currentUser if there's already a user signed in on
    // this device.
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) {
      // but if not, Google should try to sign one in whos previously signed in
      // on this phone.
      user = await googleSignIn.signInSilently();
    }
    // NB: This could still possibly be null.
    googleUser = user;
    return user;
  }

  Future<Null> logIntoFirebase() async {
    // This method will be used in two cases,
    // To make it work from both, we'll need to see if theres a user.
    // When fired from the button on the auth screen, there should
    // never be a googleUser
    if (googleUser == null) {
      // This built in method brings starts the process
      // Of a user entering their Google email and password.
      googleUser = await googleSignIn.signIn();
    }

    // This is how you'll always sign into Firebase.
    // It's all built in props and methods, so not much work on your end.
    FirebaseUser firebaseUser;
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      // Authenticate the GoogleUser
      // This will give back an access token and id token
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // Sign in to firebase with that:
//      firebaseUser = await _auth.signInWithGoogle(
//        accessToken: googleAuth.accessToken,
//        idToken: googleAuth.idToken,
//      );
      firebaseUser = await _auth.signInAnonymously();
      // Not necessary
      print('Logged in: ${firebaseUser.displayName}');


      setState(() {
        // Updating the isLoading will force the Homepage to change because of
        // The inheritedWidget setup.
        state.isLoading = false;
        // Add the use to the global state
        state.user = firebaseUser;
      });
    } catch (error) {
      print(error);
      return null;
    }
  }
}

// This is likely all your InheritedWidget will ever need.
class _InheritedStateContainer extends InheritedWidget {
  // The data is whatever this widget is passing down.
  final _AppStateContainerState data;

  // InheritedWidgets are always just wrappers.
  // So there has to be a child,
  // Although Flutter just knows to build the Widget thats passed to it
  // So you don't have have a build method or anything.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a better way to do this, which you'll see later.
  // But basically, Flutter automatically calls this method when any data
  // in this widget is changed.
  // You can use this method to make sure that flutter actually should
  // repaint the tree, or do nothing.
  // It helps with performance.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
