import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const PageButton({
    Key? key,
    required this.label,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isActive ? Theme.of(context).primaryColor.withOpacity(0.5) : Theme.of(context).canvasColor.withOpacity(0.5),
          ),
          width: 80,
          height: 80,
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Theme.of(context).canvasColor : Theme.of(context).primaryColor.withOpacity(0.7),
                fontSize: 40,
                // color: isActive,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
