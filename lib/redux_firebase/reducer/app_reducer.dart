import 'package:flutter_app_example/redux_firebase/models/app_state.dart';
import 'package:flutter_app_example/redux_firebase/reducer/counter_reducer.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: false,
    count: counterReducer(state.count, action),
  );
}