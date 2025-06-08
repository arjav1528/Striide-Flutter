import 'package:flutter/material.dart';
import 'package:striide_flutter/core/theme/app_theme.dart';

class ReportSubmitButtonWidget extends StatelessWidget {
  final VoidCallback? onSubmit;
  final bool isEnabled;
  final String text;

  const ReportSubmitButtonWidget({
    super.key,
    this.onSubmit,
    this.isEnabled = true,
    this.text = 'Submit report',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onSubmit : null,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 50,
        decoration: BoxDecoration(
          gradient: isEnabled
              ? AppTheme.primaryGradient
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.grey.shade700,
                    Colors.grey.shade600,
                  ],
                ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: const Color(0xFF6B18D8).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}