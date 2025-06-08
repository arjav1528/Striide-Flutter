import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';

class OnboardingHeader extends StatelessWidget {
  final String title;
  final String privacyText;
  final String highlightedText;
  final Color highlightColor;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const OnboardingHeader({
    super.key,
    required this.title,
    required this.privacyText,
    required this.highlightedText,
    required this.highlightColor,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightMultiplier = size.height / 852;
    final widthMultiplier = size.width / 393;

    return StaggeredList(
      itemDelay: const Duration(milliseconds: 150),
      itemDuration: const Duration(milliseconds: 600),
      children: [
        // Title section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24 * widthMultiplier,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFD4AF37),
                letterSpacing: 0.5,
                fontFamily: AppTheme.primaryFontFamily,
              ),
            ),
          ],
        ),

        SizedBox(height: 20 * heightMultiplier),

        // Privacy/Public notice
        Container(
          padding: EdgeInsets.all(12 * widthMultiplier),
          decoration: BoxDecoration(
            color: const Color(0xFF282632).withOpacity(0.7),
            borderRadius: BorderRadius.circular(12 * widthMultiplier),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: privacyText,
                      style: TextStyle(
                        fontSize: 16 * widthMultiplier,
                        color: Colors.white,
                        fontFamily: AppTheme.bodyFontFamily,
                      ),
                      children: [
                        TextSpan(
                          text: highlightedText,
                          style: TextStyle(
                            color: highlightColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * widthMultiplier,
                            fontFamily: AppTheme.bodyFontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4 * heightMultiplier),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16 * widthMultiplier,
                  color: Colors.white,
                  fontFamily: AppTheme.bodyFontFamily,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20 * heightMultiplier),

        // Action text
        Text(
          title.contains("almost")
              ? "Share a little about you !"
              : "Let's build your profile !",
          style: TextStyle(
            fontSize: 18 * widthMultiplier,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: AppTheme.bodyFontFamily,
          ),
        ),
      ],
    );
  }
}
