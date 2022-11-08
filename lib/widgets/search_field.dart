import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_catalog/api_models/characters.dart' as api;
import 'package:rick_and_morty_catalog/api_models/enums.dart';
import 'package:rick_and_morty_catalog/providers/api_data.dart';
import 'package:rick_and_morty_catalog/providers/categories.dart';

import 'animated_fade_transition.dart';

final isExpanded = StateProvider<bool>((ref) => false);

class SearchField extends HookConsumerWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
    TextEditingController textEditingController = useTextEditingController();
    final searchText = ref.watch(searchNameProvider);
    Type currentCat = ref.watch(currentCategoryTypeProvider);
    final gender = ref.watch(searchGenderProvider);
    final status = ref.watch(searchStatusProvider);
    final species = ref.watch(searchSpeciesProvider);
    final isFilterEnabled = ref.watch(isFilterAppliedProvider);
    textEditingController.text = searchText;
    Widget itemsCount = SizedBox(
      height: 44,
      child: ref.watch(paramsUpdateProvider).when(
            data: (data) => data > 0
                ? Center(
                    child: Text(
                      'Found: $data ${currentCat.toString().toLowerCase()}',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : Text(''),
            loading: () => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: LinearProgressIndicator(),
              ),
            ),
            error: (_, __) => Text('error'),
          ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 120,
                    // height: watch(containerHeight).state ? 200 : 50,
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    // padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            color: Colors.black12,
                            blurRadius: 7.0)
                      ],
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
                          hintText: 'Search',
                          suffixIcon: searchText.isNotEmpty
                              ? GestureDetector(
                                  child: Icon(Icons.clear),
                                  onTap: () {
                                    textEditingController.clear();
                                    ref
                                        .read(categoryPagesProvider.notifier)
                                        .resetCurrentCategoryPage();
                                    ref
                                        .read(searchNameProvider.notifier)
                                        .state = '';
                                  },
                                )
                              : null,
                        ),
                        style: TextStyle(fontSize: 20.0),
                        onSubmitted: (text) {
                          if (text.trim().isNotEmpty) {
                            ref
                                .read(categoryPagesProvider.notifier)
                                .resetCurrentCategoryPage();
                            ref.read(searchNameProvider.notifier).state =
                                text.trim();
                          } else {
                            textEditingController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.filter,
                      color:
                          isFilterEnabled ? Colors.blue.shade600 : Colors.grey,
                    ),
                    onTap: () {
                      cardA.currentState?.toggleExpansion();
                    },
                  )
                ],
              ),
              if (currentCat == api.Characters)
                Container(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Gender: '),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        child: Row(
                                          children: [
                                            FilterChip(
                                              label: Text("Male"),
                                              selectedColor: Colors.lightBlue,
                                              selected: gender == 'Male',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(searchGenderProvider
                                                          .notifier)
                                                      .state =
                                                  value ? 'Male' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Female"),
                                              selectedColor: Colors.pinkAccent,
                                              selected: gender == 'Female',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(searchGenderProvider
                                                          .notifier)
                                                      .state =
                                                  value ? 'Female' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Genderless"),
                                              selectedColor: Colors.lightGreen,
                                              selected: gender == 'Genderless',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(searchGenderProvider
                                                          .notifier)
                                                      .state =
                                                  value ? 'Genderless' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Unknown"),
                                              selectedColor: Colors.grey,
                                              selected: gender == 'Unknown',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(searchGenderProvider
                                                          .notifier)
                                                      .state =
                                                  value ? 'Unknown' : null,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Status: '),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        child: Row(
                                          children: [
                                            FilterChip(
                                              label: Text("Alive"),
                                              selectedColor: Colors.lightGreen,
                                              selected: status == 'Alive',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(searchStatusProvider
                                                          .notifier)
                                                      .state =
                                                  value ? 'Alive' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Dead"),
                                              selectedColor: Colors.redAccent,
                                              selected: status == 'Dead',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(searchStatusProvider
                                                          .notifier)
                                                      .state =
                                                  value ? 'Dead' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Unknown"),
                                              selectedColor: Colors.grey,
                                              selected: status == 'Unknown',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(searchStatusProvider
                                                          .notifier)
                                                      .state =
                                                  value ? 'Unknown' : null,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Species: '),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            FilterChip(
                                              label: Text("Human"),
                                              selectedColor: Colors.lightGreen,
                                              selected: species == 'Human',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value ? 'Human' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Alien"),
                                              selectedColor: Colors.redAccent,
                                              selected: species == 'Alien',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value ? 'Alien' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Humanoid"),
                                              selectedColor: Colors.redAccent,
                                              selected: species == 'Humanoid',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value ? 'Humanoid' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Poopybutthole"),
                                              selectedColor: Colors.redAccent,
                                              selected:
                                                  species == 'Poopybutthole',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value
                                                      ? 'Poopybutthole'
                                                      : null,
                                            ),
                                            FilterChip(
                                              label: Text("Animal"),
                                              selectedColor: Colors.grey,
                                              selected: species == 'Animal',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value ? 'Animal' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Robot"),
                                              selectedColor: Colors.grey,
                                              selected: species == 'Robot',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value ? 'Robot' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Disease"),
                                              selectedColor: Colors.grey,
                                              selected: species == 'Disease',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value ? 'Disease' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Cronenberg"),
                                              selectedColor: Colors.grey,
                                              selected: species == 'Cronenberg',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value ? 'Cronenberg' : null,
                                            ),
                                            FilterChip(
                                              label: Text("Planet"),
                                              selectedColor: Colors.grey,
                                              selected: species == 'Planet',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value ? 'Planet' : null,
                                            ),
                                            FilterChip(
                                              label:
                                                  Text("Mythological Creature"),
                                              selectedColor: Colors.grey,
                                              selected: species ==
                                                  'Mythological Creature',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value
                                                      ? 'Mythological Creature'
                                                      : null,
                                            ),
                                            FilterChip(
                                              label: Text("Unknown"),
                                              selectedColor: Colors.grey,
                                              selected: species == 'Unknown',
                                              backgroundColor:
                                                  Colors.transparent,
                                              onSelected: (value) => ref
                                                      .read(
                                                          searchSpeciesProvider
                                                              .notifier)
                                                      .state =
                                                  value ? 'Unknown' : null,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                DropdownButton<String>(
                                  hint: Text('Select type'),
                                  items: ref
                                      .read(typesListProvider)
                                      .map((value) => DropdownMenuItem(
                                            value: value,
                                            child: Text(value),
                                          ))
                                      .toList(),
                                  value: ref
                                      .read(
                                      searchTypesProvider.notifier)
                                      .state,
                                  onChanged: (value) {
                                    ref
                                        .read(searchTypesProvider.notifier)
                                        .state = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              if (isFilterEnabled)
                TextButton.icon(
                  icon: FaIcon(
                    FontAwesomeIcons.times,
                  ),
                  label: Text('Reset'),
                  onPressed: () {
                    textEditingController.clear();
                    ref
                        .read(categoryPagesProvider.notifier)
                        .resetCurrentCategoryPage();
                    ref.read(searchGenderProvider.notifier).state = null;
                    ref.read(searchStatusProvider.notifier).state = null;
                    ref.read(searchSpeciesProvider.notifier).state = null;
                    ref.read(searchTypesProvider.notifier).state = null;
                  },
                ),
            ],
          ),
          if (searchText.isNotEmpty)
            AnimatedFadeTransition(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Search results for: ',
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: '"$searchText"',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text('Clear'),
                      onPressed: () {
                        textEditingController.clear();
                        ref
                            .read(categoryPagesProvider.notifier)
                            .resetCurrentCategoryPage();
                        ref.read(searchNameProvider.notifier).state = '';
                      },
                    )
                  ],
                ),
              ),
            ),
          itemsCount,
        ],
      ),
    );
  }
}
