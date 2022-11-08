import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_catalog/api_models/episodes.dart';
import 'package:rick_and_morty_catalog/api_models/locations.dart';
import 'package:rick_and_morty_catalog/constants/constants.dart';
import 'package:rick_and_morty_catalog/providers/api_data.dart';
import 'package:rick_and_morty_catalog/ui/shopping_cart.dart';
import 'package:rick_and_morty_catalog/widgets/character_card.dart';
import 'package:rick_and_morty_catalog/widgets/episodes_card.dart';
import 'package:rick_and_morty_catalog/widgets/loading_card.dart';
import 'package:rick_and_morty_catalog/widgets/locations_card.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({Key? key, required this.location}) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Hero(
                  tag: '${location.id}${location.name}',
                  child: Text(
                    location.name,
                    style: GoogleFonts.ptMono(
                        fontSize: 30.0,
                        color: Colors.brown,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        shadows: []),
                  ),
                ),
                Text('Type:'),
                Text('${location.type}'),
                Text('Dimension:'),
                Text('${location.dimension}'),
                Text('Created:'),
                Text('${location.created}'),
                Text('Residents:'),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: location.residents.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Consumer(
                          builder: (context, ref, child) {
                            final locationPr = ref.watch(characterProvider(location.residents[index]));
                            return locationPr.when(
                              data: (_) => CharacterCard(
                                result: _,
                                isCompact: true,
                              ),
                              loading: () => LoadingCard(isHorizontal: true),
                              error: (_, __) => Center(
                                child: Text(
                                  _.toString(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          backButton(context),
        ],
      ),
    );
  }
}
