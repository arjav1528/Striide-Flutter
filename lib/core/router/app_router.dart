import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:striide_flutter/features/login/screens/auth_screen.dart';
import 'package:striide_flutter/features/splash_screen.dart';
import 'package:striide_flutter/features/home/screens/home.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  state.matchedLocation,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
  );

  static GoRouter get router => _router;

  // Navigation helper methods
  static void goToLogin(BuildContext context) {
    context.go('/login');
  }

  static void goToRegister(BuildContext context) {
    context.go('/register');
  }

  static void goToHome(BuildContext context) {
    context.go('/home');
  }

  static void goToProfile(BuildContext context) {
    context.go('/profile');
  }

  static void goToSettings(BuildContext context) {
    context.go('/settings');
  }

  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  static void pushNamed(
    BuildContext context,
    String name, {
    Map<String, String>? pathParameters,
  }) {
    context.pushNamed(name, pathParameters: pathParameters ?? {});
  }

  static void replaceNamed(
    BuildContext context,
    String name, {
    Map<String, String>? pathParameters,
  }) {
    context.pushReplacementNamed(name, pathParameters: pathParameters ?? {});
  }
}
