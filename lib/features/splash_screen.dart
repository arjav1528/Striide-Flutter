import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLogger.info('SplashScreen displayed');

    return GradientContainer(
      child: Align(
        alignment: Alignment.center,
        child: FadeInWidget(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 200),
          slideOffset: const Offset(0.0, 0.5),
          curve: Curves.easeOutBack,
          child: const Text(
            'Striide',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
