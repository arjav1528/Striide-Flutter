import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:striide_flutter/screens/complete_profile_1.dart';
import 'package:striide_flutter/screens/home.dart';
import 'package:striide_flutter/screens/login.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? 'https://your-supabase-url.supabase.co',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'your-anon-key',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: true, home: ScreenWrapper());
  }
}

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({super.key});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  final supabase = Supabase.instance.client;
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

            final isNewUser =
                lastSignInAt != null &&
                DateTime.parse(lastSignInAt).difference(DateTime.parse(createdAt)).inMinutes < 2;

            return  isNewUser ? CompleteProfile1() : HomeScreen();
          } else {
            return LoginScreen();
          }
        } else {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 50.0,
            ),
          );
        }
      },
    );
  }
}
