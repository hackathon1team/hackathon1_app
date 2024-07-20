import 'package:flutter/material.dart';
import 'package:memory_app/screen/remind_question1_screen.dart';

import 'remind_question2_screen.dart';
import 'remind_question3_screen.dart';
import 'remind_question4_screen.dart';
import 'remind_question5_screen.dart';

class RemindQuestionScreen extends StatefulWidget {
  int currentIndex;

  RemindQuestionScreen({super.key, required this.currentIndex});

  @override
  State<RemindQuestionScreen> createState() => _RemindQuestionScreenState();
}

class _RemindQuestionScreenState extends State<RemindQuestionScreen> {
  void onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  List<Widget> _widgetOptions() {
    return [
      RemindQuestion1Screen(
        next: () => onItemTapped(1),
      ),
      RemindQuestion2Screen(
        next: () => onItemTapped(2),
        previous: () => onItemTapped(0),
      ),
      RemindQuestion3Screen(
        next: () => onItemTapped(3),
        previous: () => onItemTapped(1),
      ),
      RemindQuestion4Screen(
        next: () => onItemTapped(4),
        previous: () => onItemTapped(2),
      ),
      RemindQuestion5Screen(
        previous: () => onItemTapped(3),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return _widgetOptions().elementAt(widget.currentIndex!);
  }
}
