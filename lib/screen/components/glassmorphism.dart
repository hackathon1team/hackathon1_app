import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class Glassmorphism extends StatelessWidget {
  final Widget child;
  const Glassmorphism({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 0.7,
        child: GlassContainer(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          blur: 50,
          color: Colors.white.withOpacity(0.05),
          shadowColor: Colors.black.withOpacity(0.25),
          shadowStrength: 10,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFFFFE7E7).withOpacity(0.46),
              Color(0xFFFFFFFF).withOpacity(0.47),
              Color(0xFF000000),
              Color(0xFFFFFFFF).withOpacity(0.3),
              Color(0xFF7381FF).withOpacity(0.45),
              Color(0xFF000749).withOpacity(0.31),
            ],
            stops: [
              0.0,
              0.07,
              0.24,
              0.58,
              0.81,
              1.0,
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
