import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_catalog/api_models/characters.dart';
import 'package:rick_and_morty_catalog/constants/constants.dart';
import 'package:rick_and_morty_catalog/providers/api_data.dart';
import 'package:rick_and_morty_catalog/widgets/episodes_card.dart';
import 'package:rick_and_morty_catalog/widgets/locations_card.dart';
import 'package:rick_and_morty_catalog/extensions/extensions.dart';

class CharacterDetails extends ConsumerWidget {
  const CharacterDetails({required this.result, Key? key}) : super(key: key);
  final Character result;

  @override
  Widget build(BuildContext context, watch) {
    print('build ${(this).toString()}');

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Container(
            child: CachedNetworkImage(
              imageUrl: result.image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          SafeArea(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Hero(
                        tag: '${result.id}${result.image}',
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4.0,
                            ),
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(imageUrl: result.image),
                          ),
                        ),
                      ),
                      Hero(
                        tag: '${result.id}${result.name}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            result.name,
                            style: GoogleFonts.ptMono(
                                fontSize: 30.0,
                                color: Colors.brown,
                                //fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                shadows: []),
                          ),
                        ),
                      ),
                      Text(
                        result.species
                            .toString()
                            .split('.')
                            .last
                            .capFirstLetter(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        result.type,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      Text('Location:'),
                      Container(
                        height: 200,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final episode =
                            ref.watch(locationProvider(result.location.url));
                            return episode.map(
                                data: (_) => LocationsCard(
                                      result: _.value,
                                      isHorizontal: true,
                                    ),
                                loading: (_) => Center(
                                    child: Center(
                                        child: CircularProgressIndicator())),
                                error: (_) => Text(_.error.toString()));
                          },
                        ),
                      ),
                      Text('Origin:'),
                      Container(
                        height: 200,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final episode =
                            ref.watch(locationProvider(result.origin.url));
                            return episode.map(
                                data: (_) => Card(
                                      child: Text(_.value.name),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                loading: (_) =>
                                    Center(child: CircularProgressIndicator()),
                                error: (_) => Text(_.error.toString()));
                          },
                        ),
                      ),
                      Text('Appeared in:'),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: result.episode.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Consumer(
                              builder: (context, ref, child) {
                                final episode = ref.watch(
                                    episodeProvider(result.episode[index]));
                                return episode.map(
                                    data: (_) => Row(
                                          children: [
                                            Text(_.value.episode),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              _.value.name,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                    loading: (_) => Container(
                                          width: 200,
                                          height: 200,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                    error: (_) => Text(_.error.toString()));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          backButton(context),
        ],
      ),
    );
  }
}
