import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:striide_flutter/features/login/screens/welcome_screen.dart';
import 'package:striide_flutter/features/onboarding/screens/complete_profile_1.dart';
import 'package:striide_flutter/features/splash_screen.dart';
import 'package:striide_flutter/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging
  AppLogger.info('App starting up');

  // Load environment variables
  await dotenv.load(fileName: AppAssets.envFile);
  AppLogger.info('Environment variables loaded');

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? 'https://your-supabase-url.supabase.co',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'your-anon-key',
  );
  AppLogger.info('Supabase initialized');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Initialize UIUtils with context
        UIUtils.init(context);
        AppLogger.info('UIUtils initialized');

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: SplashWrapper(),
        );
      },
    );
  }
}

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  void _navigateAfterSplash() {
    Future.delayed(Duration(milliseconds: AppConstants.splashDuration), () {
      if (mounted) {
        AppLogger.navigation('SplashScreen', 'MainApp');
        Navigator.pushReplacement(
          context,
          AppAnimations.fadeTransition(ScreenWrapper()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({super.key});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper>
    with WidgetsBindingObserver {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AppLogger.lifecycle('App initialized');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    AppLogger.lifecycle('App lifecycle changed to: ${state.name}');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final session = snapshot.data?.session;
          if (session != null) {
            final currentUser = session.user;
            final createdAt = currentUser.createdAt;
            final lastSignInAt = currentUser.lastSignInAt;

            AppLogger.auth('User session found', userId: currentUser.id);

            final isNewUser =
                lastSignInAt != null &&
                DateTime.parse(
                      lastSignInAt,
                    ).difference(DateTime.parse(createdAt)).inMinutes <
                    2;

            AppLogger.navigation(
              'ScreenWrapper',
              isNewUser ? 'CompleteProfile1' : 'HomeScreen',
            );

            return isNewUser ? CompleteProfile1() : HomeScreen();
          } else {
            AppLogger.auth('No user session found');
            AppLogger.navigation('ScreenWrapper', 'AuthScreen');
            return AuthScreen();
          }
        } else {
          return Center(
            child: FadeInWidget(
              duration: const Duration(milliseconds: 300),
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          );
        }
      },
    );
  }
}
