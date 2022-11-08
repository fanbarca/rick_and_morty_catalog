import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_catalog/api_models/characters.dart';
import 'package:rick_and_morty_catalog/providers/navigator_2.0.dart';
import 'package:rick_and_morty_catalog/ui/character_details_screen.dart';
import 'package:rick_and_morty_catalog/extensions/extensions.dart';

class CharacterCard extends ConsumerWidget {
  final Character result;
  final bool isCompact;
  const CharacterCard({
    Key? key,
    required this.result,
    required this.isCompact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        ref.read(pagesProvider.notifier).addPage(
              page: MaterialPage(
                // key: ValueKey('CharacterDetails'),
                child: CharacterDetails(
                  result: result,
                ),
              ),
            );
      },
      child: Container(
        // padding: EdgeInsets.only(left: 100),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        height: 160.0,
        width: isCompact ? 160 : double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(
          //   colors: [
          //     Colors.tealAccent.shade100,
          //     Colors.cyan.shade200,
          //   ],
          //   end: Alignment.bottomCenter,
          //   begin: Alignment.topLeft,
          // ),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(80),
            right: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.5, 4.0),
              color: Colors.black.withOpacity(0.4),
              blurRadius: 15.0,
              spreadRadius: 1,
            )
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              left: 0.0,
              // right: 0.0,
              width: 160,
              height: 160,
              child: CharacterAvatar(result: result),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 8.0,
                    right: 5.0,
                    child: Hero(
                      tag: '${result.id}${result.name}',
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: 220,
                          height: 60,
                          child: Text(
                            result.name,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.ptMono(
                                // letterSpacing: -0.8,
                                fontSize: result.name.length < 13
                                    ? 28.0
                                    : result.name.length > 22
                                        ? 16
                                        : (38.0 - result.name.length),
                                color: Colors.brown,
                                //fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                shadows: []),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100.0,
                    right: 10.0,
                    child: Text(result.id.toString()),
                  ),
                  Positioned(
                    bottom: 80,
                    right: 10,
                    child: Text(
                      result.type.isNotEmpty ? result.type : result.species.toString().split('.').last.capFirstLetter(),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 6.0,
                    right: 6.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: FaIcon(
                            result.gender == 'Male'
                                ? FontAwesomeIcons.mars
                                : result.gender == 'Female'
                                    ? FontAwesomeIcons.venus
                                    : result.gender == 'Genderless'
                                        ? FontAwesomeIcons.genderless
                                        : FontAwesomeIcons.question,
                            size: 42,
                            color: result.gender == 'Male'
                                ? Colors.blueAccent
                                : result.gender == 'Female'
                                    ? Colors.redAccent
                                    : result.gender == 'Genderless'
                                        ? Colors.green
                                        : Colors.blueGrey.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Chip(
                          label: Text(
                            '${result.status.toString().split('.').last.capFirstLetter()}',
                            style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              color: result.status == 'Alive'
                                  ? Colors.green.shade800
                                  : result.status == 'Dead'
                                      ? Colors.red.shade900
                                      : Colors.grey.shade600,
                            ),
                          ),
                          backgroundColor: result.status == 'Alive'
                              ? Colors.green.shade100
                              : result.status == 'Dead'
                                  ? Colors.red.shade100
                                  : Colors.grey.shade300,
                          avatar: Icon(
                            Icons.circle,
                            size: 17,
                            color: result.status == 'Alive'
                                ? Colors.green
                                : result.status == 'Dead'
                                    ? Colors.red.shade700
                                    : Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15),
                              top: Radius.circular(15),
                            ),
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.blueGrey.shade200,
                              width: 3,
                            ),
                          ),
                          padding: EdgeInsets.only(top: 4),
                          width: 44,
                          height: 62,
                          child: Column(
                            children: [
                              Text(
                                '${result.episode.length}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    //fontStyle: FontStyle.italic,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                    shadows: []),
                              ),
                              Text(
                                'Ep${result.episode.length > 1 ? 's.' : '.'}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    //fontStyle: FontStyle.italic,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                    shadows: []),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   bottom: 10.0,
                  //   right: 10.0,
                  //   child:
                  // ),
                  // Positioned(
                  //   bottom: 30.0,
                  //   left: 40.0,
                  //   child: Text(
                  //     'Last known location:',
                  //     style: GoogleFonts.ptMono(
                  //         fontSize: 15.0, color: Colors.brown,
                  //         //fontStyle: FontStyle.italic,
                  //         // fontWeight: FontWeight.bold,
                  //         shadows: []),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Positioned(
            //   bottom: 6.0,
            //   left: 20.0,
            //   child: Text(
            //     '${result.location.name}',
            //     overflow: TextOverflow.ellipsis,
            //     style: GoogleFonts.ptMono(
            //         fontSize: 20.0,
            //         color: Colors.teal,
            //         // fontStyle: FontStyle.italic,
            //         fontWeight: FontWeight.bold,
            //         shadows: []),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({
    Key? key,
    this.result,
  }) : super(key: key);

  final Character? result;

  @override
  Widget build(BuildContext context) {
    return result != null
        ? Hero(
            tag: '${result!.id}${result!.image}',
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4.0,
                ),
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: result!.image,
                  placeholder: (context, url) => CircularProgressIndicator(
                    strokeWidth: 15,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          )
        : Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4.0,
              ),
            ),
            child: ClipOval(
              child: CircularProgressIndicator(
                strokeWidth: 15,
              ),
            ),
          );
  }
}
