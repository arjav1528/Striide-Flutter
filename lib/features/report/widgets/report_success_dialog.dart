import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';

class ReportSuccessDialog extends StatefulWidget {
  const ReportSuccessDialog({super.key});

  @override
  State<ReportSuccessDialog> createState() => _ReportSuccessDialogState();
}

class _ReportSuccessDialogState extends State<ReportSuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    // Auto dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            height: UIUtils.screenHeight * 0.38,
            decoration: BoxDecoration(
              color: const Color(0xFF292732),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Map Icon
                const Icon(Icons.map, color: Colors.white, size: 60),
                UIUtils.verticalSpace24,

                // Main Title
                const Text(
                  'Report submitted',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),

                UIUtils.verticalSpace12,

                // Subtitle
                const Text(
                  'Your report helps us create a safer community for everyone',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),

                UIUtils.verticalSpace24,

                // Cursive Thank you text
                const Text(
                  'Thank you',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'OoohBaby', // Using a script-style font
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper function to show the dialog
void showReportSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return const ReportSuccessDialog();
    },
  );
}