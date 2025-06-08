import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';

class ContinueButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;
  final String text;

  const ContinueButton({
    super.key,
    required this.isEnabled,
    this.onPressed,
    this.text = "CONTINUE",
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightMultiplier = size.height / 852;
    final widthMultiplier = size.width / 393;

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child:
      // Triple arrow icon
      _buildArrow(widthMultiplier, isEnabled),
    );
  }
}

Widget _buildArrow(double widthMultiplier, bool isEnabled) {
  return Stack(
    children: [
      Icon(
        Icons.arrow_forward_ios_rounded,
        size: 50 * widthMultiplier,
        color: isEnabled ? Color(0xFFa9a4ad) : Color(0xFF272732),
      ),
      Row(
        children: [
          SizedBox(width: 30 * widthMultiplier),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 50 * widthMultiplier,
            color: isEnabled ? Color(0xFFd4cdd6) : Color(0xFF272732),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(width: 60 * widthMultiplier),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 50 * widthMultiplier,
            color: isEnabled ? Colors.white : Color(0xFF272732),
          ),
        ],
      ),
    ],
  );
}
