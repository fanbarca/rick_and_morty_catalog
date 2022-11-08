import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_catalog/api_models/characters.dart';
import 'package:rick_and_morty_catalog/ui/character_details_screen.dart';
import 'package:rick_and_morty_catalog/extensions/extensions.dart';

class LoadingCard extends StatelessWidget {
  final bool isHorizontal;
  const LoadingCard({
    Key? key,
    required this.isHorizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          // padding: EdgeInsets.only(left: 100),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          height: 160.0,
          // width: isHorizontal ? 300 : double.infinity,
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
                width: 160,
                height: 160,
                child: Container(
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120.0),
                child: Stack(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
