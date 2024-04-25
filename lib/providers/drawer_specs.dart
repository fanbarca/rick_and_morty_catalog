import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerSpecsProvider = StateNotifierProvider((ref) => DrawerSpecs());

class DrawerSpecs extends StateNotifier {
  DrawerSpecs([_drawerValue]) : super(0);

  double get getDrawerValue {
    return state;
  }

  incrementDrawerValue(double i) {
    state += i;
  }

  decrementDrawerValue(double i) {
    state -= i;
  }

  setDrawerValue(double i) {
    state = i;
  }
}
