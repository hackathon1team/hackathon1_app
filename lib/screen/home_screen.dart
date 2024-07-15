import 'package:flutter/material.dart';
import 'package:memory_app/screen/components/app_navigation_bar.dart';

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
      body: TimeLedgerScreen(),
      bottomNavigationBar: AppNavigationBar(currentIndex: 0,),
    );
  }
}
