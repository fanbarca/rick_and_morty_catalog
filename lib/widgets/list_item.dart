import 'package:flutter/material.dart';
import 'package:rick_and_morty_catalog/constants/constants.dart';

class ListItem extends StatelessWidget {
  final String title;
  const ListItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Colors.grey,
            ),
          ],
          borderRadius: BorderRadius.circular(5)),
      child: title == LoadingIndicatorTitle ? CircularProgressIndicator() : Text(title),
      alignment: Alignment.center,
    );
  }
}
