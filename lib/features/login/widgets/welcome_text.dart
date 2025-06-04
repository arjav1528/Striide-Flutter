import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main title
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'Welcome to ',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 32),
              ),
              TextSpan(
                text: 'Striide',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Montserrat',
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Thank you subtitle
        const Text(
          'Thank you',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontFamily: 'OoohBaby',
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        // Main description
        const Text(
          'for joining us in building a\nconnected and aware community\nwhere we look out for each other.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontFamily: 'Nunito',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        // Beta description
        const Text(
          'During this Beta phase, we\nencourage you to share your\nfeedback, report any issues, and\nsuggest improvements.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontFamily: 'Nunito',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
