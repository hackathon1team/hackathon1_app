import 'package:flutter/material.dart';
import 'package:memory_app/screen/home_screen.dart';

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static void navigateToHome() {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => HomeScreen(currentIndex: 0),
      ),
          (route) => false,
    );
  }
}