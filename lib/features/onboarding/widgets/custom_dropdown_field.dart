import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final String hintText;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    this.value,
    required this.hintText,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightMultiplier = size.height / 852;
    final widthMultiplier = size.width / 393;

    return Container(
      height: 72 * heightMultiplier,
      width: 329 * widthMultiplier,
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
          // Label header
          Container(
            height: 32 * heightMultiplier,
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

          // Dropdown area
          Container(
            height: 40 * heightMultiplier,
            padding: EdgeInsets.symmetric(horizontal: 16 * widthMultiplier),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12 * widthMultiplier),
                bottomRight: Radius.circular(12 * widthMultiplier),
              ),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value?.isNotEmpty == true ? value : null,
                hint: Text(
                  hintText,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontFamily: AppTheme.bodyFontFamily,
                    fontSize: 14 * widthMultiplier,
                  ),
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF00A886),
                  size: 24 * widthMultiplier,
                ),
                dropdownColor: Colors.white,
                onChanged: onChanged,
                items:
                    options.map<DropdownMenuItem<String>>((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppTheme.bodyFontFamily,
                            fontSize: 14 * widthMultiplier,
                          ),
                        ),
                      );
                    }).toList(),
                padding: EdgeInsets.zero,
                menuMaxHeight: 200 * heightMultiplier,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
