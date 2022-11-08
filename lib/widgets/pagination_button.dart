// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:rick_and_morty_catalog/api_models/episodes.dart';
// import 'package:rick_and_morty_catalog/providers/api_data.dart';
// import 'package:rick_and_morty_catalog/providers/categories.dart';

// import 'pagination.dart';

// class PaginationButton extends ConsumerWidget {
//   const PaginationButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, watch) {
//     final page = watch(categoriesProvider).currentCategoryPage;
//     final maxPages = context.read(maxPagesProvider).state;

//     final isEpisodes = watch(currentCategoryTypeProvider).state == Episodes;
//     final searchName = watch(searchNameProvider).state;
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Wrap(
//         crossAxisAlignment: WrapCrossAlignment.center,
//         children: [
//           // FloatingActionButton(
//           //   mini: true,
//           //   heroTag: null,
//           //   child: Icon(Icons.arrow_back_ios_rounded),
//           //   onPressed: () {
//           //     context.read(categoriesProvider).decrementCurrentCategoryPage();
//           //   },
//           // ),
//           // SizedBox(width: 8),
//           FloatingActionButton.extended(
//             heroTag: null,
//             label: Text(
//               (isEpisodes && searchName.isEmpty ? 'Season' : 'Page') + ' $page of $maxPages',
//               style: TextStyle(fontSize: 18),
//             ),
//             onPressed: () {
//               // if (maxPages > 1)
//               //   showModalBottomSheet(
//               //     isScrollControlled: false,
//               //     enableDrag: true,
//               //     elevation: 0,
//               //     backgroundColor: Colors.transparent,
//               //     context: context,
//               //     builder: (context) {
//               //       return Pagination();
//               //     },
//               //   );
//             },
//             // backgroundColor: Colors.redAccent,
//           ),
//           // SizedBox(width: 8),
//           // FloatingActionButton(
//           //   mini: true,
//           //   heroTag: null,
//           //   child: Icon(Icons.arrow_forward_ios_rounded),
//           //   onPressed: () {
//           //     context.read(categoriesProvider).incrementCurrentCategoryPage();
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }
// }
