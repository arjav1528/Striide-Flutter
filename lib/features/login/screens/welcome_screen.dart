import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:striide_flutter/features/login/widgets/welcome_text.dart';
import 'package:striide_flutter/features/login/widgets/custom_button.dart';
import 'package:striide_flutter/features/login/screens/auth_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('AuthScreen initialized');
  }

  @override
  void dispose() {
    AppLogger.info('AuthScreen disposed');
    super.dispose();
  }

  void _navigateToLogin() {
    AppLogger.userAction('Sign In button clicked');
    AppLogger.navigation('AuthScreen', 'LoginScreen');
    Navigator.push(
      context,
      AppAnimations.fadeSlideTransition(const LoginScreen()),
    );
  }

  void _navigateToSignUp() {
    AppLogger.userAction('Sign Up button clicked');
    // For now, both buttons go to login since we only have phone auth
    _navigateToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                // Welcome text section with animation
                FadeInWidget(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 100),
                  slideOffset: const Offset(0.0, 0.3),
                  child: const WelcomeText(),
                ),
                const SizedBox(height: 80),
                // Buttons section with staggered animation
                StaggeredList(
                  itemDelay: const Duration(milliseconds: 150),
                  itemDuration: const Duration(milliseconds: 500),
                  children: [
                    // Sign up button (primary)
                    AnimatedButton(
                      child: CustomButton(
                        text: 'Sign up',
                        onPressed: _navigateToSignUp,
                        isPrimary: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sign in button (secondary)
                    AnimatedButton(
                      child: CustomButton(
                        text: 'Sign in',
                        onPressed: _navigateToLogin,
                        isPrimary: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
