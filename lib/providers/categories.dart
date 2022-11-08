import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_catalog/api_models/characters.dart';
import 'package:rick_and_morty_catalog/api_models/episodes.dart';
import 'package:rick_and_morty_catalog/api_models/locations.dart';


final categoriesListProvider = Provider<List<Type>>((ref) {
  return [Characters, Episodes, Locations];
});


final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});


final currentCategoryTypeProvider = Provider<Type>((ref) {
  return ref
      .read(categoriesListProvider)[ref.watch(currentIndexProvider)];
});


// final categoryMaxPagesProvider = StateProvider<List<int>>((ref) {
//   return [2, 2, 2];
// });


final currentCategoryPageProvider = StateProvider<int>((ref) {
  int _page = ref.watch(categoryPagesProvider);
  return _page;
});


// final currentCategoryMaxPagesProvider = StateProvider<int>((ref) {
//   List<int> _pages = ref.watch(categoryMaxPagesProvider).state;
//   return _pages[ref.watch(currentIndexProvider).state];
// });

////////////////////////////////////////////////////////////////////////////////////////////////

final categoryPagesProvider = StateNotifierProvider<CategoryPages, int>((ref) {
  return CategoryPages();
});


class CategoryPages extends StateNotifier<int> {
  CategoryPages()
      : super(1);

  Future handleItemCreated(int index) async {
   const int ItemRequestThreshold = 20;
    var itemPosition = index + 1;
    var requestMoreData =
        itemPosition % ItemRequestThreshold == 0 && itemPosition != 0;
    var pageToRequest = (itemPosition ~/ ItemRequestThreshold) + 1;

    if (requestMoreData && pageToRequest > state) {
      state = pageToRequest;
      print('PAGE UPDATED!');
    }
  }

  void resetCurrentCategoryPage() {
    if (state>1)
    state = 1;
  }

}