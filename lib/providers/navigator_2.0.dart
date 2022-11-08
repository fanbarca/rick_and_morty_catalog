import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_catalog/ui/splash_screen.dart';

final pagesProvider = StateNotifierProvider<PagesStack, List<Page<dynamic>>>((ref) {
  return PagesStack();
});

class PagesStack extends StateNotifier<List<Page<dynamic>>> {
  PagesStack()
      : super([
          MaterialPage(child: SplashScreen()),
        ]);

  final Page first = MaterialPage(child: SplashScreen());

  void addPage({
    required Page page,
  }) {
    // state = [
    //   first, //MaterialPage(child: SplashScreen()),
    //   page,
    // ];

    if (state.length == 2)
      state = [
        ...state,
        page,
      ];
    else if (state.length == 3)
      state = [
        first, //state[1], //MaterialPage(child: SplashScreen()),
        state[2],
        page,
      ];
    else
      state = [
        ...state, //MaterialPage(child: SplashScreen()),
        page,
      ];
  }

  void removeLast() {
    state.removeLast();
    // state = state.where((element) => state.indexOf(element) != state.length - 1).toList();
    // state = [first];
  }
}
