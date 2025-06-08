import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';

class LocationInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const LocationInputWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a42),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Nunito',
        ),
        decoration: InputDecoration(
          hintText: 'Location',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 14,
            fontFamily: 'Nunito',
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
        ),
      ),
    );
  }
}