import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;

// ignore: non_constant_identifier_names
Widget FeatureButton(String title, CustomPaint icon, context) {
  return GestureDetector(
    onTap: () async {
      AppLogger.info('Feature button pressed: $title');
      if (title.toLowerCase() == 'report') {
        // Get current location before navigating to report
        try {
          // Check location services and request permissions
          bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
          if (!serviceEnabled) {
            // Show location services dialog
            await gl.Geolocator.openLocationSettings();
            return;
          }

          gl.LocationPermission permission =
              await gl.Geolocator.checkPermission();
          if (permission == gl.LocationPermission.denied) {
            permission = await gl.Geolocator.requestPermission();
            if (permission == gl.LocationPermission.denied) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Location permission is required for reporting',
                  ),
                ),
              );
              return;
            }
          }

          if (permission == gl.LocationPermission.deniedForever) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Location permission is permanently denied. Please enable in settings.',
                ),
                duration: Duration(seconds: 3),
              ),
            );
            return;
          }

          // Get current position
          gl.Position position = await gl.Geolocator.getCurrentPosition();

          // Convert to mapbox position format
          final mapPosition = mp.Position(
            position.longitude,
            position.latitude,
          );

          // Navigate to report with position
          AppRouter.pushNamed(
            context,
            'report',
            queryParameters: {},
            extra: mapPosition,
          );
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error getting location: $error')),
          );
        }
      } else {
        AppRouter.pushNamed(context, title.toLowerCase());
      }
    },
    child: Builder(
      builder: (context) {
        UIUtils.init(context);
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: UIUtils.spacing48 - UIUtils.spacing4, // 44
                  height: UIUtils.spacing48 - UIUtils.spacing4, // 44
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(12), // 12
                  ),
                ),
                icon,
              ],
            ),
            UIUtils.verticalSpace(2),
            Text(
              title,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface.withOpacity(0.87),
              ),
            ),
          ],
        );
      },
    ),
  );
}
