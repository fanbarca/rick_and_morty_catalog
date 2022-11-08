import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_catalog/api_models/characters.dart';
import 'package:rick_and_morty_catalog/api_models/episodes.dart';
import 'package:rick_and_morty_catalog/providers/api_data.dart';
import 'package:rick_and_morty_catalog/providers/navigator_2.0.dart';
import 'package:rick_and_morty_catalog/ui/episode_details_screen.dart';

import 'character_card.dart';

class SeasonsCard extends ConsumerWidget {
  final Episodes result;
  final bool isHorizontal;
  // final index;
  const SeasonsCard({
    Key? key,
    required this.result,
    this.isHorizontal = false,
    // this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    return GestureDetector(
      onTap: () {
        // context.read(pagesProvider.notifier).addPage(
        //       page: MaterialPage(
        //         // key: ValueKey('CharacterDetails'),
        //         child: EpisodeDetails(
        //           episode: result,
        //         ),
        //       ),
        //     );
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30.0),
            height: 170.0,
            // width: isHorizontal ? 200.0 : double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
//          gradient: RadialGradient(
//            colors: [Colors.black, Colors.transparent],
//            radius: 1.9,
//            center: Alignment(0.0, 4.0),
//          ),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -3),
                  color: Colors.black12,
                  blurRadius: 7.0,
                )
              ],
            ),
            child: Stack(
              children: <Widget>[
                // Positioned(
                //   top: 20.0,
                //   left: 20.0,
                //   child: Text(
                //     '${result.name}',
                //     style: GoogleFonts.neucha(
                //         fontSize: 30.0,
                //         color: Colors.brown,
                //         //fontStyle: FontStyle.italic,
                //         fontWeight: FontWeight.bold,
                //         shadows: []),
                //   ),
                // ),
                // Positioned(
                //   top: 50.0,
                //   left: 20.0,
                //   child: Text(
                //     '${result.episode}',
                //     style: GoogleFonts.ptMono(
                //         fontSize: 20.0,
                //         color: Colors.brown,
                //         //fontStyle: FontStyle.italic,
                //         fontWeight: FontWeight.bold,
                //         shadows: []),
                //   ),
                // ),
                // Positioned(
                //   bottom: 40.0,
                //   left: 20.0,
                //   child: Text(
                //     '${result.airDate}',
                //     style: GoogleFonts.ptMono(
                //         fontSize: 20.0,
                //         color: Colors.brown,
                //         //fontStyle: FontStyle.italic,
                //         fontWeight: FontWeight.bold,
                //         shadows: []),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
