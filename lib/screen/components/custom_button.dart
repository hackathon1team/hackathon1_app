import 'package:flutter/material.dart';

import '../../const/colors.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final bool right;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.right, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      child: Row(
        children: [
          right ? Container() : Image.asset('assets/react-icon/leftArrow.png'),
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
          right ? Image.asset(right ? 'assets/react-icon/rightArrow.png' : 'assets/react-icon/leftArrow.png') : Container(),
        ],
      ),
    );
  }
}
