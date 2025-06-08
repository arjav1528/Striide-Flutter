import 'package:flutter/material.dart';
import 'package:striide_flutter/core/theme/app_theme.dart';

class FeedbackSubmitButtonWidget extends StatelessWidget {
  final VoidCallback? onSubmit;
  final bool isEnabled;
  final String text;

  const FeedbackSubmitButtonWidget({
    super.key,
    this.onSubmit,
    this.isEnabled = true,
    this.text = 'Submit',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        onPressed: isEnabled ? onSubmit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.gradientColors.first,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child:
            text.contains('Submitting')
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isEnabled
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      text,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
                : Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
      ),
    );
  }
}
