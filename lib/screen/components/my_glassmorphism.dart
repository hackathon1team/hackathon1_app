import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class MyGlassmorphism extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const MyGlassmorphism({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        shadowColor: Colors.black.withOpacity(0.25),
        blur: 2,
        shadowStrength: 5,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE7E7).withOpacity(0.46),
            Colors.white.withOpacity(0.47),
            Colors.black.withOpacity(0),
            Colors.white.withOpacity(0.3),
            Color(0xFF7381FF).withOpacity(0.45),
            Color(0xFF000749).withOpacity(0.31),
          ],
          stops: [
            0,
            0.07,
            0.24,
            0.58,
            0.81,
            1.0,
          ],
        ),
        child: child,
      ),
    );
  }
}
