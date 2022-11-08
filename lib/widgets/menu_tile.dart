import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_catalog/providers/categories.dart';

class MenuTile extends ConsumerWidget {
  MenuTile({
    Key? key,
    this.index,
    required this.onTap,
  }) : super(key: key);
  final index;

  final Function onTap;

  @override
  Widget build(BuildContext context, watch) {
    Size size = MediaQuery.of(context).size;
    // Categories categories = watch(categoriesProvider);

    double height = size.height * 0.09;
    double width = size.width;
    // bool isCurrent = index == categories.currentIndex;

    return Stack(
      children: <Widget>[
        GestureDetector(
          //dragStartBehavior: DragStartBehavior.down,
          onTap: onTap(),
          child: Container(
//            curve: Curves.easeOut,
//            duration: Duration(milliseconds: 100),
//            transform: Matrix4.identity()
//              ..scale(isCurrent ? newScale * 1.1 : newScale)
//              ..rotateZ(-0.05 * (index - categories.categoriesCount / 2.5)),
            margin: EdgeInsets.only(
                //top: 10.0,
                //right: isCurrent ? 10.0 : 30,
//                  : 10.0 + 15.0 + (index - categories.currentIndex).abs() * 15,
                //right: 10.0,
                //bottom: 10.0,
                ),
            height: height,
            width: width,
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(left: 15),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
//                border: isCurrent
//                    ? Border.all(
//                        color: Colors.white,
//                        width: 3.0,
//                      )
//                    : null,
//                 color: isCurrent ? Colors.white24 : Colors.transparent,
                //boxShadow: [kBoxShadow],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0), bottomLeft: Radius.circular(100.0)),
//                image: DecorationImage(
//                  image:
//                      AssetImage('images/${categories.categories[index]}.jpg'),
//                  fit: BoxFit.cover,
//                ),
              ),
              // child: Align(
              // alignment: Alignment.centerLeft,
              // child:
//                Text(
//                  categories.categories[index],
//                  style: isCurrent ? kTitleMedium : kTitle,
//                ),

              // Text(
              // categories.categories[index],
              // style: GoogleFonts.gloriaHallelujah(color: Colors.white, fontSize: 40, textBaseline: TextBaseline.ideographic, fontWeight: FontWeight.bold),
              // ),
              // ),
            ),
          ),
        ),
      ],
    );
  }
}

//class MyClipper extends CustomClipper<Path> {
//  @override
//  Path getClip(Size size) {
//    double height = 20;
//    Path path = Path();
//    path.lineTo(0.0, size.height);
//    path.quadraticBezierTo(size.width / 4, size.height - height, size.width / 2,
//        size.height - height);
//    path.quadraticBezierTo(size.width - (size.width / 4), size.height - height,
//        size.width, size.height);
//    path.lineTo(size.width, 0.0 - height);
//    path.quadraticBezierTo(
//        size.width - (size.width / 4), 0.0, size.width / 2, 0.0);
//    path.quadraticBezierTo(size.width / 4, 0.0, 0, height);
//    path.close();
//    return path;
//  }
//
//  @override
//  bool shouldReclip(CustomClipper<Path> oldClipper) {
//    return false;
//  }
//}
