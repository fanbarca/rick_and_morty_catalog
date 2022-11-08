import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class FadeOnScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;
  final bool shouldScale;
  final bool shouldBlur;

  FadeOnScroll({
    Key? key,
    required this.scrollController,
    required this.child,
    required this.shouldScale,
    this.zeroOpacityOffset = 0,
    this.fullOpacityOffset = 0,
    this.shouldBlur = false,
  });

  @override
  _FadeOnScrollState createState() => _FadeOnScrollState();
}

class _FadeOnScrollState extends State<FadeOnScroll> {
  late double _offset;

  @override
  initState() {
    super.initState();
    _offset = widget.scrollController.offset;
    widget.scrollController.addListener(_setOffset);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
    });
  }

  double _calculateOpacity() {
    if (widget.fullOpacityOffset == widget.zeroOpacityOffset)
      return 1;
    else if (widget.fullOpacityOffset > widget.zeroOpacityOffset) {
      // fading in
      if (_offset <= widget.zeroOpacityOffset)
        return 0;
      else if (_offset >= widget.fullOpacityOffset)
        return 1;
      else
        return (_offset - widget.zeroOpacityOffset) / (widget.fullOpacityOffset - widget.zeroOpacityOffset);
    } else {
      // fading out
      if (_offset <= widget.fullOpacityOffset)
        return 1;
      else if (_offset >= widget.zeroOpacityOffset)
        return 0;
      else
        return (_offset - widget.zeroOpacityOffset) / (widget.fullOpacityOffset - widget.zeroOpacityOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _calculateOpacity(),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: widget.shouldScale ? _calculateOpacity() * 70 : double.infinity,
          child: widget.child,
        ),
      ),
    );
  }
}
