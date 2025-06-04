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
  AppLogger.info('App starting up');

  await dotenv.load(fileName: AppAssets.envFile);
  AppLogger.info('Environment variables loaded');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? 'https://your-supabase-url.supabase.co',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'your-anon-key',
  );
  AppLogger.info('Supabase initialized');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        UIUtils.init(context);
        AppLogger.info('UIUtils initialized');

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const SplashWrapper(),
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
          AppAnimations.fadeTransition(const ScreenWrapper()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({super.key});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper>
    with WidgetsBindingObserver {
  final _supabase = Supabase.instance.client;

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
    return StreamBuilder<AuthState>(
      stream: _supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        AppLogger.debug(snapshot.data.toString());

        if (snapshot.connectionState == ConnectionState.waiting) {
          AppLogger.info('Auth state: waiting for connection');
          return _buildLoadingScreen();
        }

        if (snapshot.hasError) {
          AppLogger.error('Auth state error: ${snapshot.error}');
          return _buildErrorScreen(snapshot.error.toString());
        }

        if (snapshot.hasData) {
          final authState = snapshot.data!;
          final event = authState.event;
          final session = authState.session;

          AppLogger.auth('Auth event: ${event.name}');

          if (session != null) {
            final currentUser = session.user;
            AppLogger.auth('User session found', userId: currentUser.id);

            return event == AuthChangeEvent.signedIn
                ? _handleSignInEvent(currentUser)
                : _handleExistingUserSession(currentUser);
          } else {
            AppLogger.auth('No user session found');
            AppLogger.navigation('ScreenWrapper', 'AuthScreen');
            return AuthScreen();
          }
        }

        return _buildLoadingScreen();
      },
    );
  }

  Widget _handleSignInEvent(User currentUser) {
    final createdAt = currentUser.createdAt;
    final lastSignInAt = currentUser.lastSignInAt;

    final isNewSignUp =
        lastSignInAt != null &&
        DateTime.parse(
              lastSignInAt,
            ).difference(DateTime.parse(createdAt)).inMinutes <
            2;

    AppLogger.navigation(
      'ScreenWrapper',
      isNewSignUp ? 'CompleteProfile1' : 'HomeScreen',
    );

    return isNewSignUp ? CompleteProfile1() : HomeScreen();
  }

  Widget _handleExistingUserSession(User currentUser) {
    return FutureBuilder(
      future:
          _supabase
              .from('profiles')
              .select('first_name, last_name')
              .eq('userId', currentUser.id)
              .single(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingScreen();
        }

        if (snapshot.hasError) {
          AppLogger.error('Error fetching profile: ${snapshot.error}');
          return HomeScreen();
        }

        final data = snapshot.data;
        final hasCompletedProfile =
            data != null &&
            data['first_name'] != null &&
            data['first_name'].toString().isNotEmpty;

        AppLogger.navigation(
          'ScreenWrapper',
          hasCompletedProfile ? 'HomeScreen' : 'CompleteProfile1',
        );

        return hasCompletedProfile ? HomeScreen() : CompleteProfile1();
      },
    );
  }

  Widget _buildLoadingScreen() {
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

  Widget _buildErrorScreen(String errorMessage) {
    return Scaffold(
      backgroundColor: const Color(0xFF282632),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Authentication Error',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Please restart the app or try again later',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await _supabase.auth.signOut();
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    AppAnimations.fadeTransition(AuthScreen()),
                  );
                }
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
