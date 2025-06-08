import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:striide_flutter/core/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('SplashScreen displayed');
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() {
    Future.delayed(Duration(milliseconds: AppConstants.splashDuration), () {
      if (mounted) {
        AppLogger.navigation('SplashScreen', 'AuthScreen');
        context.go('/auth');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
