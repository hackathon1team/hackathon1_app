import 'package:flutter/material.dart';

import '../../const/colors.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final bool right;
  final VoidCallback? onPressed;
  final Color backgroundcolor;
  const CustomButton({super.key, required this.text, required this.right, required this.onPressed, required this.backgroundcolor,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: backgroundcolor,
      ),
      child: Row(
        children: [
          right ? Container() : Icon(Icons.chevron_left),
          right ? Container() : SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: buttonTextColor),
          ),
          right ? SizedBox(
            width: 5,
          ) : Container(),
          right ? Icon(Icons.chevron_right) : Container(),
        ],
      ),
    );
  }
}
