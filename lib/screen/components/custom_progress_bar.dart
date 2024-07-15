import 'package:flutter/material.dart';

import '../../const/colors.dart';


class CustomProgressBar extends StatelessWidget {
  final double value;

  const CustomProgressBar({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 300,
          height: 7,
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Positioned(
          left: 300 * value - 15, // Adjust -10 to center the image
          top: -12,

          child: Image.asset(
            'assets/components/star.png', // Your custom image
            width: 30,
            height: 30,
          ),
        ),
      ],
    );
  }
}