import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:striide_flutter/features/login/screens/widgets/welcome_text.dart';
import 'package:striide_flutter/features/login/screens/widgets/custom_button.dart';
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
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight - mediaQuery.padding.vertical,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:
                          isSmallScreen
                              ? screenHeight * 0.05
                              : screenHeight * 0.1,
                    ),
                    FadeInWidget(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 100),
                      slideOffset: const Offset(0.0, 0.3),
                      child: const WelcomeText(),
                    ),
                    SizedBox(
                      height:
                          isSmallScreen
                              ? screenHeight * 0.04
                              : screenHeight * 0.08,
                    ),
                    StaggeredList(
                      itemDelay: const Duration(milliseconds: 150),
                      itemDuration: const Duration(milliseconds: 500),
                      children: [
                        AnimatedButton(
                          child: CustomButton(
                            text: 'Sign up',
                            onPressed: _navigateToSignUp,
                            isPrimary: true,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        AnimatedButton(
                          child: CustomButton(
                            text: 'Sign in',
                            onPressed: _navigateToLogin,
                            isPrimary: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:
                          isSmallScreen
                              ? screenHeight * 0.03
                              : screenHeight * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
