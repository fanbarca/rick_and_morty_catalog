import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_catalog/api_models/episodes.dart';
import 'package:rick_and_morty_catalog/constants/constants.dart';
import 'package:rick_and_morty_catalog/providers/api_data.dart';
import 'package:rick_and_morty_catalog/providers/navigator_2.0.dart';
import 'package:rick_and_morty_catalog/widgets/character_card.dart';
import 'package:rick_and_morty_catalog/widgets/episodes_card.dart';
import 'package:rick_and_morty_catalog/widgets/loading_card.dart';
import 'package:rick_and_morty_catalog/providers/navigator_2.0.dart';

import 'character_details_screen.dart';

class EpisodeDetails extends StatelessWidget {
  const EpisodeDetails({Key? key, required this.episode}) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Scaffold(
            body: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Hero(
                      tag: '${episode.id}${episode.name}',
                      child: Text(
                        episode.name,
                        style: GoogleFonts.ptMono(
                            fontSize: 30.0,
                            color: Colors.brown,
                            //fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            shadows: []),
                      ),
                    ),
                    Text('Episode:'),
                    Text('${episode.episode}'),
                    Text('Aired:'),
                    Text('${episode.airDate}'),
                    Text('Created:'),
                    Text('${episode.created}'),
                    Text('${episode.characters.length} characters:'),
                    GridView.builder(
                      reverse: false,
                      physics: BouncingScrollPhysics(),
                      itemCount: episode.characters.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Consumer(
                          builder: (context, ref, child) {
                            final character = ref.watch(characterProvider(episode.characters[index]));
                            return character.map(
                              data: (_) => GestureDetector(
                                child: CharacterAvatar(
                                  result: _.value,
                                ),
                                onTap: () {
                                  ref.read(pagesProvider.notifier).addPage(
                                        page: MaterialPage(
                                          // key: ValueKey('CharacterDetails'),
                                          child: CharacterDetails(
                                            result: _.value,
                                          ),
                                        ),
                                      );
                                },
                              ),
                              loading: (_) => CharacterAvatar(),
                              error: (_) => Text(_.error.toString()),
                            );
                          },
                        );
                      },
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                    ),
                  ],
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
