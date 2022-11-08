import 'package:flutter/rendering.dart';

class ConcaveCurvedBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = 30;
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(size.width / 4, size.height - height, size.width / 2,
        size.height - height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height - height,
        size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
