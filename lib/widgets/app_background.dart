import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3A0CA3),
            Color.fromARGB(255, 32, 0, 126),
            Color(0xFF4361EE),
            Color.fromARGB(255, 49, 203, 250),
          ],
        ),
      ),
      child: child,
    );
  }
}
