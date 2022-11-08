import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_catalog/providers/categories.dart';

class CategoryBackgroundImage extends HookConsumerWidget  {
  const CategoryBackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    String cat = ref.watch(currentCategoryTypeProvider).toString();

    Widget image = Container(
      key: ValueKey('$cat'),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'images/$cat.png',
          ),
        ),
      ),
    );

    return AnimatedSwitcher(

      duration: Duration(milliseconds: 300),
      child: image,
    );
  }
}
