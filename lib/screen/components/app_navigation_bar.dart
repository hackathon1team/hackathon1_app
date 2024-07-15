import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  final int currentIndex;
  const AppNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF73648E),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFF564B6A),
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(Icons.home),
            ),
            label: '홈'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(Icons.question_answer_outlined),
            ),
            label: '메코의 질문'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(Icons.bar_chart),
            ),
            label: '통계'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(Icons.wysiwyg),
            ),
            label: '감정 돌아보기'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(Icons.person),
            ),
            label: 'MY'),
      ],
    );
  }
}
