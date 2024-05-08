import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class customeButton extends StatelessWidget {
  customeButton({
    super.key,
    required this.title,
    required this.colortext,
    this.onTap,
    required this.colorBack,
  });
  final String title;
  final Color colortext;
  final void Function()? onTap;
  final Color colorBack;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 40,
        child: Center(
            child: Text(
          '$title',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: colortext,
          ),
        )),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: BorderSide.strokeAlignCenter,
              offset: Offset(2, 3))
        ], borderRadius: BorderRadius.circular(40), color: colorBack),
      ),
    );
  }
}
