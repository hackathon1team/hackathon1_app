import 'package:flutter/material.dart';
import 'package:memory_app/screen/components/app_navigation_bar.dart';
import 'package:memory_app/screen/static_screen.dart';

import 'time_ledger_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaticScreen(),
      bottomNavigationBar: AppNavigationBar(currentIndex: 2,),
    );
  }
}
