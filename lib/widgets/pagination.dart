// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:rick_and_morty_catalog/providers/categories.dart';
// import 'package:rick_and_morty_catalog/ui/shopping_cart.dart';

// import 'page_button.dart';

// class Pagination extends HookWidget {
//   Pagination({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Categories categories = useProvider(categoriesProvider);
//     ScrollController _scrollController = useScrollController(
//       keepScrollOffset: true,
//     );
//     return ClipPath(
//       clipper: CurvedTop(),
//       child: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         controller: _scrollController,
//         child: Container(
//           color: Colors.white.withOpacity(0.4),
//           child: Wrap(
//             alignment: WrapAlignment.center,
//             direction: Axis.horizontal,
//             children: [
//               ...List.generate(
//                 context.read(categoriesProvider).currentCategoryMaxPages,
//                 (index) => PageButton(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     if (index + 1 != categories.currentCategoryPage) context.read(categoriesProvider).setCurrentCategoryPage(index + 1);
//                   },
//                   label: '${index + 1}',
//                   isActive: index + 1 == categories.currentCategoryPage,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
