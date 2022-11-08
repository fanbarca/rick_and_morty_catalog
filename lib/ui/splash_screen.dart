import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_catalog/clippers/concave_curved_bottom.dart';
import 'package:rick_and_morty_catalog/constants/constants.dart';
import 'package:rick_and_morty_catalog/constants/enter_animation.dart';
import 'package:rick_and_morty_catalog/providers/api_data.dart';
import 'package:rick_and_morty_catalog/providers/categories.dart';
import 'package:rick_and_morty_catalog/widgets/category_background.dart';
import 'package:rick_and_morty_catalog/widgets/creation_aware_widget.dart';
import 'package:rick_and_morty_catalog/widgets/episodes_card.dart';
import 'package:rick_and_morty_catalog/widgets/fade_on_scroll.dart';
import 'package:rick_and_morty_catalog/widgets/character_card.dart';
import 'package:rick_and_morty_catalog/widgets/locations_card.dart';
import 'package:rick_and_morty_catalog/widgets/animated_fade_transition.dart';
import 'package:rick_and_morty_catalog/widgets/search_field.dart';

class SplashScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    print('build ${(this).toString()}');

    ScrollController _scrollController =
        useScrollController(initialScrollOffset: 0);
    AnimationController _controller =
        useAnimationController(duration: Duration(seconds: 2));
    EnterAnimation animation = EnterAnimation(_controller);
    _controller.forward();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Opacity(
          opacity: 0.5,
          child: Container(
            width: double.infinity,
            child: Stack(
              children: [
                // PaginationButton(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: FloatingActionButton(
                      mini: false,
                      heroTag: null,
                      child: Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () {
                        if (_scrollController.hasClients &&
                            _scrollController.offset > 200)
                          _scrollController.jumpTo(
                            200,
                            // curve: Curves.easeOut,
                            // duration: const Duration(milliseconds: 2000),
                          );
                        expandAppBar(_scrollController, animation);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: RickAndMortyBottomBar(),
        body: AnimatedBuilder(
          animation: animation.controller,
          builder: (context, child) {
            return Scrollbar(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    elevation: 0,
                    pinned: true,
                    stretch: true,
                    backgroundColor: Colors.transparent,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(22.0),
                      child: Text(''),
                    ),
                    expandedHeight: animation.barHeight.value,
                    flexibleSpace: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                            child: ClipPath(
                              clipper: ConcaveCurvedBottom(),
                              child: Stack(
                                children: <Widget>[
                                  Opacity(
                                    opacity: animation.barHeight.value / 250,
                                    child: CategoryBackgroundImage(),
                                  ),
                                ],
                              ),
                            ),
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.diagonal3Values(
                                animation.avatarSize.value * 2,
                                animation.avatarSize.value * 2,
                                1,
                              ),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                fit: StackFit.loose,
                                children: <Widget>[
                                  FadeOnScroll(
                                    zeroOpacityOffset: 180.0,
                                    fullOpacityOffset: 0.0,
                                    scrollController: _scrollController,
                                    shouldScale: true,
                                    child: ClipOval(
                                      child: Image(
                                        image: AssetImage(
                                          'images/Portal.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  FadeOnScroll(
                                    zeroOpacityOffset: 180.0,
                                    fullOpacityOffset: 0.0,
                                    scrollController: _scrollController,
                                    shouldScale: false,
                                    child: Center(
                                      child: MainCategoryTitle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: animation.titleOpacity.value,
                      decoration: BoxDecoration(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: SearchField(),
                    ),
                  ),
                  child!,
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50.0,
                    ),
                  ),
                ],
              ),
            );
          },
          child: Container(
            child: ResultList(),
          ),
        ),
      ),
    );
  }

  void resetAnimation(AnimationController _controller,
      ScrollController _scrollController) async {
    _controller.reset();
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 10),
    );
    await Future.delayed(const Duration(milliseconds: 200));
    _controller.forward();
  }

  void expandAppBar(
      ScrollController _scrollController, EnterAnimation animation) {
    if (_scrollController.hasClients && _scrollController.offset > 10)
      _scrollController.animateTo(
        0,
        curve: Curves.easeOutExpo,
        duration: const Duration(milliseconds: 1500),
      );
  }
}

class ResultList extends StatelessWidget {
  ResultList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build ${(this).toString()}');
    return Consumer(builder: (context, ref, child) {
      var itemList = ref.watch(itemsProvider);
      ref.watch(pageUpdateProvider);
      ref.watch(paramsUpdateProvider);

      bool hasData = itemList.length > 0;
      return hasData
          ? SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == itemList.length)
                    return Consumer(builder: (context, ref, child) {
                      var isLoading = ref.watch(loadingProvider);
                      return isLoading
                          ? SizedBox(
                              height: 100,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : SizedBox(
                              height: 100,
                            );
                    });
                  return AnimatedFadeTransition(
                    child: CreationAwareListItem(
                      itemCreated: () {
                        print('Item created # ${index + 1}');
                        SchedulerBinding.instance.addPostFrameCallback(
                          (duration) => ref
                              .read(categoryPagesProvider.notifier)
                              .handleItemCreated(index),
                        );
                      },
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: buildCard(itemList[index], context, ref),
                      ),
                    ),
                  );
                },
                childCount: itemList.length + 1, //child.results.length,
                // data.length, //child.results.length,
              ),
            )
          : SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: Center(
                  child: Consumer(builder: (context, ref, child) {
                    return ref.watch(paramsUpdateProvider).when(
                        data: (_) => Text(
                              'Nothing found',
                              style: TextStyle(
                                  fontSize: 40, color: Colors.blueGrey),
                            ),
                        loading: () => Text(
                              'Loading...',
                              style: TextStyle(
                                  fontSize: 40, color: Colors.blueGrey),
                            ),
                        error: (_, __) => Text(
                              'Something went wrong',
                              style: TextStyle(
                                  fontSize: 40, color: Colors.blueGrey),
                            ));
                  }),
                ),
              ),
            );
    });
  }

  dynamic buildCard(dynamic item, BuildContext context, ref) {
    int currentIndex = ref.watch(currentIndexProvider);
    switch (currentIndex) {
      case 0:
        return CharacterCard(
          result: item,
          isCompact: false,
        );
      case 1:
        return EpisodesCard(
          result: item,
          isHorizontal: false,
        );
      case 2:
        return LocationsCard(
          result: item,
          isHorizontal: false,
        );
      default:
        break;
    }
  }
}

class MainCategoryTitle extends HookConsumerWidget {
  const MainCategoryTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var cat = ref.watch(currentCategoryTypeProvider).toString();
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeInCirc,
      switchInCurve: Curves.elasticOut,
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      duration: Duration(milliseconds: 1000),
      child: Text(
        ' ' + cat + ' ',
        key: ValueKey('$cat'),
        style: kTitle,
      ),
    );
  }
}

class RickAndMortyBottomBar extends HookConsumerWidget {
  const RickAndMortyBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    int currentIndex = ref.watch(currentIndexProvider);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).cardColor,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).backgroundColor,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      onTap: (index) {
        if (index != currentIndex) {
          ref.read(categoryPagesProvider.notifier).resetCurrentCategoryPage();
          ref.read(itemsProvider.notifier).clearPage();
          ref.read(currentIndexProvider.notifier).state = index;
          // expandAppBar(_scrollController, animation);
          // resetAnimation(_controller, _scrollController);
        }
      },
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.userAstronaut),
          label: ref.read(categoriesListProvider)[0].toString(),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.film),
          label: ref.read(categoriesListProvider)[1].toString(),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.mapMarker),
          label: ref.read(categoriesListProvider)[2].toString(),
        ),
      ],
    );
  }
}
