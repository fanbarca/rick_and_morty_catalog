import 'package:flutter/widgets.dart';

class EnterAnimation {
  final AnimationController controller;
  final Animation<double> barHeight;
  final Animation<double> avatarSize;
  final Animation<double> titleOpacity;
  final Animation<double> textOpacity;

  EnterAnimation(this.controller)
      : barHeight = Tween<double>(begin: 0, end: 250).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.35, curve: Curves.easeOutQuart),
          ),
        ),
        avatarSize = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.2, 0.8, curve: Curves.elasticOut),
          ),
        ),
        titleOpacity = Tween<double>(begin: 800, end: 30).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 0.8, curve: Curves.easeOutCirc),
          ),
        ),
        textOpacity = Tween<double>(begin: 5, end: 0.6).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.easeOutCirc),
          ),
        );
}
