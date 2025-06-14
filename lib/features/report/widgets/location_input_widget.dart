import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;

class LocationInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onMapPickerPressed;

  const LocationInputWidget({
    super.key,
    required this.controller,
    this.onMapPickerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a42),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: const Color(0xFF6B18D8),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Nunito',
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter location coordinates',
                  hintStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: 'Nunito',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.map_outlined, color: Color(0xFF6B18D8)),
              onPressed: onMapPickerPressed,
            ),
          ],
        ),
      ),
    );
  }
}
