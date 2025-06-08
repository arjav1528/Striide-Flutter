import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final int maxLines;
  final double? height;

  const CustomFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
    this.maxLines = 1,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightMultiplier = size.height / 852;
    final widthMultiplier = size.width / 393;

    final fieldHeight = height ?? 90 * heightMultiplier;
    final fieldWidth = 329 * widthMultiplier;

    return Container(
      height: fieldHeight,
      width: fieldWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12 * widthMultiplier),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Field label headers
          Container(
            height: 40 * heightMultiplier,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16 * widthMultiplier,
              vertical: 6 * heightMultiplier,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12 * widthMultiplier),
                topRight: Radius.circular(12 * widthMultiplier),
              ),
              color: const Color(0xFF00A886),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14 * widthMultiplier,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppTheme.bodyFontFamily,
                ),
              ),
            ),
          ),

          // Field input area
          Container(
            height: 50 * heightMultiplier,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12 * widthMultiplier),
                bottomRight: Radius.circular(12 * widthMultiplier),
              ),
            ),
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              maxLines: maxLines,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16 * widthMultiplier,
                  vertical: maxLines > 1 ? 12 * heightMultiplier : 0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12 * widthMultiplier),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12 * widthMultiplier),
                ),

                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: AppTheme.bodyFontFamily,
                  fontSize: 14 * widthMultiplier,
                ),
                suffixIcon: suffixIcon,
              ),
              style: TextStyle(
                color: Colors.black,
                fontFamily: AppTheme.bodyFontFamily,
                fontSize: 15 * widthMultiplier,
              ),
              cursorColor: const Color(0xFF00A886),
            ),
          ),
        ],
      ),
    );
  }
}
