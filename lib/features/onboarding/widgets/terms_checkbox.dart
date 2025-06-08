import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String text;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.text =
        "I hereby confirm that I have read and agree to the Terms of Service and Privacy Policy.",
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightMultiplier = size.height / 852;
    final widthMultiplier = size.width / 393;

    return Container(
      padding: EdgeInsets.all(12 * widthMultiplier),
      decoration: BoxDecoration(
        color: const Color(0xFF282632).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12 * widthMultiplier),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24 * widthMultiplier,
            height: 24 * heightMultiplier,
            child: Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                fillColor: WidgetStateProperty.resolveWith<Color>(
                  (states) =>
                      states.contains(WidgetState.selected)
                          ? const Color(0xFF00A886)
                          : Colors.white,
                ),
                checkColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(width: 12 * widthMultiplier),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14 * widthMultiplier,
                color: Colors.white,
                height: 1.4,
                fontFamily: AppTheme.bodyFontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
