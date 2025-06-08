import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:striide_flutter/features/login/screens/welcome_screen.dart';
import 'package:striide_flutter/features/login/screens/auth_screen.dart';
import 'package:striide_flutter/features/splash_screen.dart';
import 'package:striide_flutter/features/home/screens/home.dart';
import 'package:striide_flutter/features/home/screens/map.dart';
import 'package:striide_flutter/features/profile/screens/profile_screen.dart';
import 'package:striide_flutter/features/onboarding/screens/complete_profile_1.dart';
import 'package:striide_flutter/features/onboarding/screens/complete_profile_2.dart';
import 'package:striide_flutter/features/onboarding/screens/demo_screen.dart';
import 'package:striide_flutter/features/onboarding/screens/share_screen.dart';
import 'package:striide_flutter/features/feedback/screens/feedback.dart';

class AppRouter {
  static final _supabase = Supabase.instance.client;

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Splash Screen
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Authentication Routes
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Onboarding Routes
      GoRoute(
        path: '/onboarding/profile-1',
        name: 'profile-1',
        builder: (context, state) => const CompleteProfile1(),
      ),
      GoRoute(
        path: '/onboarding/profile-2',
        name: 'profile-2',
        builder: (context, state) => const CompleteProfile2(),
      ),
      GoRoute(
        path: '/onboarding/share',
        name: 'share',
        builder: (context, state) => const ShareScreen(),
      ),
      GoRoute(
        path: '/onboarding/demo',
        name: 'demo',
        builder: (context, state) => const DemoScreen(),
      ),

      // Main App Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/home/map',
        name: 'map',
        builder: (context, state) => const MapScreen(),
      ),

      // Profile Routes
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Feature Routes
      GoRoute(
        path: '/feedback',
        name: 'feedback',
        builder: (context, state) => const FeedbackScreen(),
      ),

      // Settings Route (placeholder for future implementation)
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder:
            (context, state) => _buildPlaceholderScreen(
              context,
              'Settings',
              'Settings screen coming soon!',
              Icons.settings,
            ),
      ),
    ],

    // Enhanced Error Handling
    errorBuilder:
        (context, state) => Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6B18D8), Color(0xFF8442E0)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Page not found',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'The route "${state.matchedLocation}" does not exist',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.home),
                    label: const Text('Go Home'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

    // Route Redirect Logic
    redirect: (context, state) {
      final session = _supabase.auth.currentSession;
      final isLoggedIn = session != null;
      final currentLocation = state.matchedLocation;

      // Public routes that don't require authentication
      final publicRoutes = ['/', '/auth', '/login'];

      // If not logged in and trying to access protected route
      if (!isLoggedIn && !publicRoutes.contains(currentLocation)) {
        return '/auth';
      }

      // If logged in and trying to access auth pages, redirect to home
      if (isLoggedIn &&
          publicRoutes.contains(currentLocation) &&
          currentLocation != '/') {
        return '/home';
      }

      return null; // No redirect needed
    },
  );

  static GoRouter get router => _router;

  // Enhanced Navigation Helper Methods

  // Authentication Navigation
  static void goToAuth(BuildContext context) {
    context.go('/auth');
  }

  static void goToLogin(BuildContext context) {
    context.go('/login');
  }

  // Onboarding Navigation
  static void goToOnboardingProfile1(BuildContext context) {
    context.go('/onboarding/profile-1');
  }

  static void goToOnboardingProfile2(BuildContext context) {
    context.go('/onboarding/profile-2');
  }

  static void goToOnboardingShare(BuildContext context) {
    context.go('/onboarding/share');
  }

  static void goToOnboardingDemo(BuildContext context) {
    context.go('/onboarding/demo');
  }

  // Main App Navigation
  static void goToHome(BuildContext context) {
    context.go('/home');
  }

  static void goToMap(BuildContext context) {
    context.go('/home/map');
  }

  static void goToProfile(BuildContext context) {
    context.go('/profile');
  }

  // Feature Navigation
  static void goToFeedback(BuildContext context) {
    context.go('/feedback');
  }

  static void goToSettings(BuildContext context) {
    context.go('/settings');
  }

  // Advanced Navigation Methods
  static void pushNamed(
    BuildContext context,
    String name, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
  }) {
    context.pushNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
    );
  }

  static void replaceNamed(
    BuildContext context,
    String name, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
  }) {
    context.pushReplacementNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
    );
  }

  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  // Utility Methods
  static void clearStackAndGoTo(BuildContext context, String path) {
    while (context.canPop()) {
      context.pop();
    }
    context.go(path);
  }

  static Future<T?> pushAsModal<T>(
    BuildContext context,
    Widget screen, {
    bool isDismissible = true,
  }) async {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      builder: (context) => screen,
    );
  }

  static Future<T?> pushAsDialog<T>(
    BuildContext context,
    Widget dialog, {
    bool barrierDismissible = true,
  }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => dialog,
    );
  }

  // Route Information Getters
  static String getCurrentRoute(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    return state.matchedLocation;
  }

  static String? getCurrentRouteName(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    return state.name;
  }

  static Map<String, String> getCurrentPathParameters(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    return state.pathParameters;
  }

  static Map<String, String> getCurrentQueryParameters(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    return state.uri.queryParameters;
  }

  // Helper method for placeholder screens
  static Widget _buildPlaceholderScreen(
    BuildContext context,
    String title,
    String message,
    IconData icon,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xFF282632),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => goBack(context),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.white54),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => goToHome(context),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
