import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedFadeTransition extends StatefulWidget {
  final Widget child;
  const AnimatedFadeTransition({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _AnimatedFadeTransitionState createState() => _AnimatedFadeTransitionState();
}

class _AnimatedFadeTransitionState extends State<AnimatedFadeTransition> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this, value: 0, lowerBound: 0, upperBound: 1);
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}
