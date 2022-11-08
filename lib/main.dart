import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_catalog/providers/navigator_2.0.dart';

import 'providers/api_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(ProviderScope(child: MyApp()));
    print('build MAIN');
  });
}

class MyApp extends ConsumerWidget {
  final heroC = HeroController();

  @override
  Widget build(BuildContext context, watch) {
    print('build $this');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primaryColor: Colors.deepOrange.shade900,
        iconTheme: IconThemeData(
            // color: Colors.deepOrange.shade900,
            ),
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.neuchaTextTheme(),
      ),
      home: Consumer(builder: (context, ref, child) {
        final pages = ref.watch(pagesProvider);
        return Navigator(
          // key: ValueKey(pages.length),
          observers: [heroC],
          pages: pages,
          onPopPage: (route, result) {
            if (!route.didPop(result)) return false;
            ref.read(pagesProvider).removeLast();
            // selectedCharacter.state = null;
            // selectedEpisode.state = null;
            // selectedLocation.state = null;
            return true;
          },
        );
      }),
    );
  }
}
