import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:striide_flutter/features/onboarding/providers/onboarding_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure enhanced logger
  AppLogger.setUseColors(true);
  AppLogger.setUseEmojis(true);
  AppLogger.setShowTimestamp(true);

  // Startup banner
  AppLogger.banner('STRIIDE APP STARTUP');

  final startTime = DateTime.now();
  AppLogger.lifecycle(
    'App Initialization Started',
    data: {
      'platform': 'Flutter',
      'build_mode': kDebugMode ? 'Debug' : 'Release',
      'timestamp': startTime.toIso8601String(),
    },
  );

  try {
    // Load environment variables
    final envStartTime = DateTime.now();
    await dotenv.load(fileName: AppAssets.envFile);
    final envDuration = DateTime.now().difference(envStartTime);

    AppLogger.performance('Environment Variables Load', envDuration);
    AppLogger.success('Environment variables loaded successfully');

    // Initialize Supabase
    final supabaseStartTime = DateTime.now();
    await Supabase.initialize(
      url:
          dotenv.env['SUPABASE_URL'] ?? 'https://your-supabase-url.supabase.co',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'your-anon-key',
    );
    final supabaseDuration = DateTime.now().difference(supabaseStartTime);

    AppLogger.performance('Supabase Initialization', supabaseDuration);
    AppLogger.success('Supabase initialized successfully');

    // Setup Map
    await setupMap();

    final totalDuration = DateTime.now().difference(startTime);
    AppLogger.performance('Total App Startup', totalDuration);

    AppLogger.box([
      'Striide App Ready! 🚀',
      'Startup Time: ${totalDuration.inMilliseconds}ms',
      'Environment: ${kDebugMode ? 'Development' : 'Production'}',
      'Features: All systems operational',
    ]);

    runApp(const MyApp());

    // Uncomment the line below to see the enhanced logger demo in action
    // LoggerDemo.runDemo();
  } catch (error, stackTrace) {
    AppLogger.exception(
      error as Exception,
      stackTrace,
      context: 'App startup failed',
      additionalData: {
        'startup_phase': 'initialization',
        'elapsed_time': DateTime.now().difference(startTime).inMilliseconds,
      },
    );
    rethrow;
  }
}

Future<void> setupMap() async {
  final mapStartTime = DateTime.now();

  try {
    MapboxOptions.setAccessToken(dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '');
    final mapDuration = DateTime.now().difference(mapStartTime);

    AppLogger.performance(
      'Mapbox Setup',
      mapDuration,
      metrics: {
        'has_access_token':
            dotenv.env['MAPBOX_ACCESS_TOKEN']?.isNotEmpty ?? false,
        'token_length': dotenv.env['MAPBOX_ACCESS_TOKEN']?.length ?? 0,
      },
    );
    AppLogger.success('Mapbox initialized successfully');
  } catch (error, stackTrace) {
    AppLogger.exception(
      error as Exception,
      stackTrace,
      context: 'Mapbox initialization failed',
      additionalData: {
        'has_token': dotenv.env['MAPBOX_ACCESS_TOKEN']?.isNotEmpty ?? false,
      },
    );
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingProvider(),
      child: LayoutBuilder(
        builder: (context, _) {
          UIUtils.init(context);
          AppLogger.info('UIUtils initialized');

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}

/* 
// These classes are no longer needed since we're using GoRouter
// The authentication logic is now handled in the router's redirect function

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

          AppLogger.auth(
            'Auth State Change',
            metadata: {
              'event': event.name,
              'session_available': session != null,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );

          if (session != null) {
            final currentUser = session.user;
            AppLogger.auth(
              'User Session Active',
              userId: currentUser.id,
              email: currentUser.email,
              metadata: {
                'session_expires_at': session.expiresAt?.toString(),
                'provider': currentUser.appMetadata['provider'] ?? 'unknown',
                'last_sign_in': currentUser.lastSignInAt,
              },
            );

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
*/
