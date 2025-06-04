import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  const GradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF590bbe),
            Color(0xFF5a0bbe),
            Color(0xFF590bbe),
            Color(0xFF5a0cbe),
            Color(0xFF4710be),
            Color(0xFF3714bd),
            Color(0xFF2418bc),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: child,
    );
  }
}
