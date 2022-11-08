import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final IconData icon;
  const CategoryButton({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(offset: Offset(0, 3), color: Colors.black12, blurRadius: 7.0)],
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      height: 100.0,
      width: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 45.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }
}
