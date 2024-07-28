import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_app/cubit/meco_question_cubit.dart';
import 'package:memory_app/cubit/time_ledger_list_cubit.dart';
import 'package:memory_app/screen/static_screen.dart';

import 'meco_question_start_screen.dart';
import 'my_page_screen.dart';
import 'remind_question_screen.dart';
import 'time_ledger_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.currentIndex, super.key});

  int currentIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  List<Widget> _widgetOptions() {
    return [
      TimeLedgerScreen(),
      MecoQuestionStartScreen(),
      StaticScreen(),
      RemindQuestionScreen(
        currentIndex: 0,
      ),
      MyPageScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions().elementAt(widget.currentIndex!),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF73648E),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF564B6A),
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
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
      ),
    );
  }
}
