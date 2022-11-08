import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_catalog/api_models/characters.dart';
import 'package:rick_and_morty_catalog/api_models/episodes.dart';
import 'package:rick_and_morty_catalog/api_models/locations.dart';

import 'categories.dart';

class HttpClient {
  final container = ProviderContainer();

  Future<dynamic> search(Map<String, String> queryParams, categoryIndex) async {
    // var category = container.read(categoriesProvider).currentCategoryType;
    // var category = Episodes;
    bool isCharacters = categoryIndex == 0;
    bool isEpisodes = categoryIndex == 1;
    bool isLocations = categoryIndex == 2;

    String type = 'character';
    if (isEpisodes)
      type = 'episode';
    else if (isLocations) type = 'location';
    var uri = Uri.https('rickandmortyapi.com', '/api/$type/', queryParams);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      if (isCharacters)
        return Characters.fromJson(json.decode(response.body));
      else if (isEpisodes)
        return Episodes.fromJson(json.decode(response.body));
      else if (isLocations)
        return Locations.fromJson(json.decode(response.body));
    } else {
      print('Failed to load post. ${response.statusCode}');
      throw Exception('Failed to load post');
    }
  }

  Future<dynamic> getItem<T>(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      if (T == Character)
        return Character.fromJson(json.decode(response.body));
      else if (T == Episode)
        return Episode.fromJson(json.decode(response.body));
      else if (T == Location)
        return Location.fromJson(json.decode(response.body));
      else if (T == Characters)
        return Characters.fromJson(json.decode(response.body));
      else if (T == Episodes)
        return Episodes.fromJson(json.decode(response.body));
      else if (T == Locations)
        return Locations.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}


final httpClientProvider = Provider((ref) => HttpClient());

final characterProvider =
    FutureProvider.family<dynamic, String>((ref, String url) async {
  final httpClient = ref.read(httpClientProvider);
  return httpClient.getItem<Character>(url);
});

final episodeProvider =
    FutureProvider.family<dynamic, String>((ref, String url) async {
  final httpClient = ref.read(httpClientProvider);
  return httpClient.getItem<Episode>(url);
});

final locationProvider =
    FutureProvider.family<dynamic, String>((ref, String url) async {
  final httpClient = ref.read(httpClientProvider);
  return httpClient.getItem<Location>(url);
});


final searchNameProvider = StateProvider<String>((ref) => '');
final isFilterAppliedProvider = StateProvider<bool>((ref) {
  return ref.watch(searchGenderProvider) != null ||
      ref.watch(searchStatusProvider) != null ||
      ref.watch(searchSpeciesProvider) != null ||
      ref.watch(searchTypesProvider) != null;
});

final searchGenderProvider = StateProvider<String?>((ref) => null);
final searchStatusProvider = StateProvider<String?>((ref) => null);
final searchSpeciesProvider = StateProvider<String?>((ref) => null);
final searchTypesProvider = StateProvider<String?>((ref) => null);

final searchQueryParamsProvider = StateProvider<Map<String, String>>((ref) {
  Map<String, String> myMap = {};
  // final cats = ref.watch(categoriesProvider);
  final name = ref.watch(searchNameProvider);
  final genderProvider = ref.watch(searchGenderProvider);
  final statusProvider = ref.watch(searchStatusProvider);
  final speciesProvider = ref.watch(searchSpeciesProvider);
  final typesProvider = ref.watch(searchTypesProvider);

  // final episode = cats.currentCategoryType == Episodes && name.isEmpty ? 'S${cats.currentCategoryPage.toString().padLeft(2, '0')}' : '';
  if (name != '') myMap.addAll({'name': name});
  if (statusProvider != null && statusProvider != '')
    myMap.addAll({'status': statusProvider});
  if (speciesProvider != null && speciesProvider != '')
    myMap.addAll({'species': speciesProvider});
  if (genderProvider != null && genderProvider != '')
    myMap.addAll({'gender': genderProvider});
  if (typesProvider != null && typesProvider != '')
    myMap.addAll({'type': typesProvider});

  return myMap;
  // {
  //   'name': name,
  //   'status': statusProvider ?? '',
  //   'species': speciesProvider ?? '',
  //   'gender': genderProvider ?? '',
  //   'type': replaceAll ?? '',
  //   'dimension': '',
  //   'episode': '',
  // };
});

// final episodeSearchProvider = FutureProvider<dynamic>((ref) async {
//   final httpClient = ref.read(httpClientProvider);
//   return httpClient.search({}, 'Episodes');
// });
final loadingProvider = StateProvider<bool>((ref) {
  return ref.watch(pageUpdateProvider).when(
      data: (data) => false, loading: () => true, error: (_, __) => false);
});

final paramsUpdateProvider = FutureProvider<dynamic>((ref) async {
  final httpClient = ref.read(httpClientProvider);
  final params = ref.watch(searchQueryParamsProvider);
  params.remove('page');
  var itemList = ref.read(itemsProvider.notifier);
  try {
    final cat = ref.watch(currentIndexProvider);
    var characters = await httpClient.search(params, cat);
    final maxPages = characters.info.pages;
    // ref.read(categoryPagesProvider.notifier).resetCurrentCategoryPage();
    // ref.read(categoriesProvider).setCurrentCategoryMaxPages(maxPages);
    itemList.updatePage(characters.results);
    return characters.info.count;
  } catch (e) {
    // ref.read(categoriesProvider).setCurrentCategoryMaxPages(2);
    ref.read(categoryPagesProvider.notifier).resetCurrentCategoryPage();
    itemList.clearPage();
    return 0;
  }
});

final pageUpdateProvider = FutureProvider<dynamic>((ref) async {
  final page = ref.watch(currentCategoryPageProvider);
  if (page > 1) {
    final httpClient = ref.read(httpClientProvider);
    final params = ref.watch(searchQueryParamsProvider);
    params.addAll({'page': page.toString()});
    final cat = ref.watch(currentIndexProvider);
    var characters = await httpClient.search(params, cat);
    // final pages = characters.info.pages;
    // ref.read(categoriesProvider).setCurrentCategoryMaxPages(pages);
    var itemList = ref.read(itemsProvider.notifier);
    itemList.nextPage(characters.results);
  }
});

// final listFutureProvider = FutureProvider<void>((ref) async {
//   var characters = await ref.watch(pageUpdateProvider.future);
//   final pages = characters.info.pages;
//   ref.read(categoriesProvider).setCurrentCategoryMaxPages(pages);
//
//   var itemList = ref.watch(itemsProvider.notifier);
//   itemList.nextList(characters.results, false);
// });

final itemsProvider = StateNotifierProvider<ItemList, List<dynamic>>(
  (ref) {
    return ItemList();
  },
);

class ItemList extends StateNotifier<List<dynamic>> {
  ItemList() : super([]);
  final container = ProviderContainer();
  void nextPage(List<dynamic> newList) {
    state = [
      ...state,
      ...newList,
    ];
    state.toSet().toList();
    print('Added items. Now ${state.length}');
  }

  void updatePage(List<dynamic> newList) {
    // container.read(categoriesProvider).resetCurrentCategoryPage();
    // if (newList)
    state = newList;
    print('Page updated! Number of items: ${state.length} ');
  }

  void clearPage() {
    // container.read(categoryPagesProvider.notifier).resetCurrentCategoryPage();
    // if (newList)
    state = [];
    print('list has been cleared!');
  }
}

final gendersListProvider = Provider((ref) => [
      "Male",
      "Female",
      "Genderless",
      "Unknown",
    ]);
final typesListProvider = Provider((ref) => [
      "Parasite",
      "Monster",
      "Bepisian",
      "Hivemind",
      "Mytholog",
      "Human with giant head",
      "Toy",
      "Dog",
      "Cat",
      "Rat",
      "Eel",
      "Shrimp",
      "Wasp",
      "Lizard",
      "Fly",
      "God",
      "Caterpillar",
      "Bird-Person",
      "Korblock",
      "Boobloosian",
      "Elephant-Person",
      "Superhuman",
      "Gromflomite",
      "Centaur",
      "Dummy",
      "Human-Snake hybrid",
      "Glorzo",
      "Clay-Person",
      "Snake",
      "Dragon",
      "Zeus",
      "Human with tusks",
      "Soulless Puppet",
      "Half Soulless Puppet",
      "Monogatron",
      "Organic gun",
      "Gramuflackian",
      "Microverse inhabitant",
      "Vampire",
      "Light bulb-Alien",
      "Animal",
      "Robot-Crocodile hybrid",
      "Zigerion",
      "Giant",
      "Demon",
      "Shapeshifter",
      "Game",
      "Amoeba-Person",
      "Clone",
      "Robot",
      "Hologram",
      "Interdimensional gaseous being",
      "Flansian",
      "Human with a flower in his head",
      "Zombodian",
      "Garblovian",
      "Gazorpian",
      "Cat-Person",
      "Traflorkian",
      "Eat shiter-Person",
      "Goddess",
      "Gazorpian reproduction robot",
      "Human Gazorpian",
      "Hammerhead-Person",
      "Hole",
      "Phone-Person",
      "Giant Testicle Monster",
      "Phone",
      "Tuskfish",
      "Alphabetrian",
      "Greebybobe",
      "Corn-person",
      "Unknown-nippled alien",
      "Ring-nippled alien",
      "Cone-nippled alien",
      "Krootabulan",
      "Plutonian",
      "Jellybean",
      "Tentacle alien",
      "Cyborg",
      "Larva alien",
      "Snail alien",
      "Tinymouth",
      "Lizard-Person",
      "Alligator-Person",
      "Octopus-Person",
      "Conjoined twin",
      "Gear-Person",
      "Sentient ant colony",
      "Boobie buyer reptilian",
      "Meeseeks",
      "The Devil",
      "Cat controlled dead lady",
      "Numbericon",
      "Hairy alien",
      "Pickle",
      "Bread",
      "Mega Gargantuan",
      "Blue ape alien",
      "Lobster-Alien",
      "Scrotian",
      "Drumbloxian",
      "Shimshamian",
      "Omniscient being",
      "Slug",
      "Stair goblin",
      "Leprechaun",
      "Mexican",
      "Floop Floopian",
      "Giant Cat Monster",
      "Old Amazons",
      "Morty's toxic side",
      "Rick's toxic side",
      "Teenyverse inhabitant",
      "Trunk-Person",
      "Grandma",
      "Tumblorkian",
      "Pripudlian",
      "Doopidoo",
      "Teddy Bear",
      "Little Human",
      "Chair",
      "Mannie",
      "Pizza",
      "Nano Alien",
      "Necrophiliac",
    ]);
