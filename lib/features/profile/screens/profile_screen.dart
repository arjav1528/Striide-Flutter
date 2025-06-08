import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/animations.dart';
import 'package:striide_flutter/core/utils/logger.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';
import 'package:striide_flutter/features/login/screens/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: // Logout button positioned at top-right
          Positioned(
        top: UIUtils.statusBarHeight + UIUtils.spacing16,
        right: UIUtils.spacing16,
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
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.surface.withOpacity(0.9),
            foregroundColor: colorScheme.onSurface,
            padding: EdgeInsets.symmetric(
              horizontal: UIUtils.spacing16,
              vertical: UIUtils.spacing8,
            ),
          ),
          child: Text("Logout", style: theme.textTheme.labelLarge),
        ),
      ),
    );
  }
}
