import 'package:flutter/material.dart';
import 'package:flutter_app_example/login_flow_boiler/app.dart';
import 'package:flutter_app_example/login_flow_boiler/app_state_container.dart';

void main() {
  runApp(AppStateContainer(
    child: AppRootWidget(),
  ));
}



