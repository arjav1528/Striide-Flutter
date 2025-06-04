import 'package:flutter/material.dart';
import 'package:striide_flutter/features/login/screens/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:striide_flutter/core/core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('HomeScreen initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StaggeredList(
          itemDelay: const Duration(milliseconds: 200),
          itemDuration: const Duration(milliseconds: 600),
          children: [
            SizedBox(height: 100),
            FadeInWidget(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 100),
              slideOffset: const Offset(0.0, 0.3),
              child: Text(
                "Welcome to Striide",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            AnimatedButton(
              child: ElevatedButton(
                onPressed: () async {
                  AppLogger.auth('User logout initiated');
                  final supabase = Supabase.instance.client;
                  await supabase.auth.signOut();
                  AppLogger.auth('User logout successful');
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      AppAnimations.fadeTransition(AuthScreen()),
                    );
                  }
                },
                child: Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
