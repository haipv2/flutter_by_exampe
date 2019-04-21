import 'package:flutter_app_example/redux_firebase/actions/counter_actions.dart';

int counterReducer(int currentCount, action) {

  if (action is IncrementCountAction) {
    currentCount++;
    return currentCount;
  } else if (action is DecrememtCountAction) {
    currentCount--;
    return currentCount;
  } else {
    return currentCount;
  }
}