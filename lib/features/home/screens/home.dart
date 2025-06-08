import 'package:flutter/material.dart';
import 'package:striide_flutter/core/constants/painter.dart';
import 'package:striide_flutter/features/home/widgets/centerButton.dart';
import 'package:striide_flutter/features/home/widgets/featureButton.dart';
import 'package:striide_flutter/features/login/screens/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:striide_flutter/core/core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _profileButtonController;
  late AnimationController _featurePanelController;
  late Animation<double> _profileButtonFadeAnimation;
  late Animation<double> _featurePanelFadeAnimation;
  late Animation<Offset> _profileButtonSlideAnimation;
  late Animation<Offset> _featurePanelSlideAnimation;

  @override
  void initState() {
    super.initState();
    AppLogger.info('HomeScreen initialized');

    // Initialize animation controllers
    _profileButtonController = AnimationController(
      duration: AppAnimations.slowDuration,
      vsync: this,
    );

    _featurePanelController = AnimationController(
      duration: AppAnimations.slowDuration,
      vsync: this,
    );

    // Initialize fade animations
    _profileButtonFadeAnimation = CurvedAnimation(
      parent: _profileButtonController,
      curve: Curves.easeOut,
    );

    _featurePanelFadeAnimation = CurvedAnimation(
      parent: _featurePanelController,
      curve: Curves.easeOut,
    );

    // Initialize slide animations
    _profileButtonSlideAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0.0), // Start from left
      end: Offset.zero,
    ).animate(_profileButtonFadeAnimation);

    _featurePanelSlideAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // Start from right
      end: Offset.zero,
    ).animate(_featurePanelFadeAnimation);

    // Start animations with delay
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        _profileButtonController.forward();
      }
    });

    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        _featurePanelController.forward();
      }
    });
  }

  @override
  void dispose() {
    _profileButtonController.dispose();
    _featurePanelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize UIUtils with current context
    UIUtils.init(context);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    CustomPaint feedbackIcon = CustomPaint(
      size: Size(
        UIUtils.homeFeatureIconSize,
        UIUtils.homeFeatureIconSize * 0.9583333333333334,
      ),
      painter: feedbackIconPainter(),
    );

    CustomPaint reportIcon = CustomPaint(
      size: Size(
        UIUtils.homeFeatureIconSize,
        UIUtils.homeFeatureIconSize * 1.1153846153846154,
      ),
      painter: reportIconPainter(),
    );

    return Scaffold(
      body: Container(
        width: UIUtils.screenWidth,
        height: UIUtils.screenHeight,
        decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
        child: Stack(
          children: [
            // Logout button positioned at top-right
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

            // Feature panel on the right side
            Positioned(
              top: UIUtils.homeFeaturePanelTopOffset,
              right: UIUtils.homeFeaturePanelRightOffset,
              child: FadeTransition(
                opacity: _featurePanelFadeAnimation,
                child: SlideTransition(
                  position: _featurePanelSlideAnimation,
                  child: Container(
                    width: UIUtils.homeFeaturePanelWidth,
                    height: UIUtils.homeFeaturePanelHeight,
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(UIUtils.cardBorderRadius * 2),
                        bottomLeft: Radius.circular(
                          UIUtils.cardBorderRadius * 2,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        UIUtils.verticalSpace20,
                        FeatureButton("Feedback", feedbackIcon),
                        UIUtils.verticalSpace24,
                        FeatureButton("Report", reportIcon),
                        UIUtils.verticalSpace24,
                        CenterButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Profile button at bottom
            Positioned(
              bottom: UIUtils.homeProfileButtonBottomOffset,
              right: UIUtils.homeProfileButtonRightOffset,
              child: FadeTransition(
                opacity: _profileButtonFadeAnimation,
                child: SlideTransition(
                  position: _profileButtonSlideAnimation,
                  child: FloatingActionButton(
                    heroTag: "profile_button",
                    shape: CircleBorder(
                      side: BorderSide(
                        color: colorScheme.surface,
                        width: UIUtils.homeProfileButtonBorderWidth,
                      ),
                    ),
                    backgroundColor: colorScheme.primary,
                    onPressed: () {
                      AppLogger.info('Profile button pressed');
                    },
                    child: Icon(
                      Icons.person_rounded,
                      color: colorScheme.onPrimary,
                      size: UIUtils.iconSizeLarge,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
