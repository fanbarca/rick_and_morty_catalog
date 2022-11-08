import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_catalog/constants/constants.dart';

final modelProvider = ChangeNotifierProvider((ref) => HomeViewModel());

class HomeViewModel extends ChangeNotifier {
  static const int ItemRequestThreshold = 15;

  late List<String> _items;
  List<String> get items => _items;

  int _currentPage = 0;

  HomeViewModel() {
    _items = [];
  }

  Future handleItemCreated(int index) async {
    var itemPosition = index + 1;
    var requestMoreData = itemPosition % ItemRequestThreshold == 0 && itemPosition != 0;
    var pageToRequest = itemPosition ~/ ItemRequestThreshold;

    if (requestMoreData && pageToRequest > _currentPage) {
      print('handleItemCreated | pageToRequest: $pageToRequest');
      _currentPage = pageToRequest;
      _showLoadingIndicator();

      await Future.delayed(Duration(seconds: 5));
      var newFetchedItems = List<String>.generate(15, (index) => 'Title page:$_currentPage item: $index');
      _items.addAll(newFetchedItems);

      _removeLoadingIndicator();
    }
  }

  void _showLoadingIndicator() {
    _items.add(LoadingIndicatorTitle);
    notifyListeners();
  }

  void _removeLoadingIndicator() {
    _items.remove(LoadingIndicatorTitle);
    notifyListeners();
  }
}
