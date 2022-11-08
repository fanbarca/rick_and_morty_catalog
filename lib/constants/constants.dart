import 'package:flutter/material.dart';

enum DrawerState { closed, closing, opening, opened }
const String LoadingIndicatorTitle = '^';

Widget backButton(context) => SafeArea(
      child: IconButton(
        color: Colors.white,
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );

Color kBackgroundColor = Colors.teal;
TextStyle kTitle = TextStyle(
  shadows: [
    Shadow(
      offset: Offset(0, 0),
      color: Colors.black.withOpacity(1),
      blurRadius: 10.0,
    )
  ],
  fontFamily: 'Neucha',
  color: Colors.white,
  fontSize: 40,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.none,
);
TextStyle kTitleMedium = TextStyle(
  shadows: [
    Shadow(
      offset: Offset(0, 0),
      color: Colors.black.withOpacity(1),
      blurRadius: 20.0,
    )
  ],
  fontFamily: 'Neucha',
  color: Colors.white,
  fontSize: 55,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.none,
);
TextStyle kTitleBig = TextStyle(
  shadows: [
    Shadow(
      offset: Offset(0, 0),
      color: Colors.black.withOpacity(1),
      blurRadius: 20.0,
    )
  ],
  fontFamily: 'Neucha',
  color: Colors.white,
  fontSize: 80,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.none,
);
BoxShadow kBoxShadow = BoxShadow(
  offset: Offset(0, 4),
  color: Colors.black.withOpacity(0.3),
  blurRadius: 7.0,
);
LinearGradient kGradient = LinearGradient(
  //stops: [0.5, 1.0],
  begin: Alignment.bottomCenter,
  end: Alignment.center,
  colors: [
    Colors.black.withOpacity(0.5),
    Colors.transparent,
  ], //
  // whitish to gray

  //tileMode: TileMode.clamp, // repeats the gradient over the canvas
);
RadialGradient kBackgroundGradient = RadialGradient(
  // transform: GradientRotation(0.4),
  stops: [0.01, 0.68, 0.99],
  radius: 3,
  focal: Alignment(-2.5, 0.8),
  center: Alignment.bottomRight,
  colors: [
    Colors.deepOrange,
    Colors.lightGreenAccent,
    Colors.cyan,
  ],
);
//
// String rickAndMortyApi(String category) {
//   if (category == (Characters).toString())
//     return rickAndMortyCharacters;
//   else if (category == (Locations).toString())
//     return rickAndMortyLocations;
//   else if (category == (Episodes).toString())
//     return rickAndMortyEpisodes;
//   else
//     return 'https://rickandmortyapi.com/api/';
// }
//
// String rickAndMortyCharacters = "https://rickandmortyapi.com/api/character";
// String rickAndMortyLocations = "https://rickandmortyapi.com/api/location";
// String rickAndMortyEpisodes = "https://rickandmortyapi.com/api/episode";
