import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final Size screenSize = MediaQuery.of(context).size;
    final double spacing = screenSize.height * 0.04;

    // Base text styles with responsive sizing

    final headerStyle = TextStyle(
      fontSize: screenSize.width * 0.08,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: 'Montserrat',
    );

    final bodyTextStyle = TextStyle(
      fontSize: screenSize.width * 0.05,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontFamily: 'Nunito',
    );

    final thanksTextStyle = TextStyle(
      fontSize: screenSize.width * 0.09,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontFamily: 'OoohBaby',
      fontStyle: FontStyle.italic,
    );

    return Column(
      children: [
        // Main title
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: headerStyle,
            children: [
              const TextSpan(text: 'Welcome to '),
              TextSpan(
                text: 'Striide',
                style: headerStyle.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        SizedBox(height: spacing),
        // Thank you subtitle
        Text('Thank you', style: thanksTextStyle, textAlign: TextAlign.center),
        SizedBox(height: spacing * 0.75),
        // Main description
        SizedBox(
          width: screenSize.width * 0.85,
          child: Text(
            'for joining us in building a\nconnected and aware community\nwhere we look out for each other.',
            style: bodyTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: spacing),
        // Beta description
        SizedBox(
          width: screenSize.width * 0.85,
          child: Text(
            'During this Beta phase, we\nencourage you to share your\nfeedback, report any issues, and\nsuggest improvements.',
            style: bodyTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
