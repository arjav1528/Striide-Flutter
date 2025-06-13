import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:striide_flutter/core/core.dart'; // For openAppSettings

// Global key to access the MapScreen state
final GlobalKey<_MapScreenState> mapScreenKey = GlobalKey<_MapScreenState>();

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  mp.MapboxMap? mapController;
  StreamSubscription? userPositionStream;
  bool _isMapInitialized = false;
  String? _locationError;
  gl.Position? _currentPosition; // Store current position

  @override
  void initState() {
    super.initState();
    _setupPositionTracking();
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          mp.MapWidget(
            onMapCreated: _onMapCreated,
            key: const ValueKey("mapbox_map"),
            onTapListener: _onMapTapped,
          ),
          if (_locationError != null)
            Positioned(
              top: 50,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _locationError!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onMapCreated(mp.MapboxMap mapboxMap) {
    setState(() {
      mapController = mapboxMap;
      _isMapInitialized = true;
    });

    // Disable the compass
    mapController!.compass.updateSettings(mp.CompassSettings(enabled: false));

    // Set dark mode using lightPreset
    mapController!.style.setStyleImportConfigProperty(
      "basemap",
      "lightPreset",
      "night",
    );

    // Disable the scale bar
    mapController?.scaleBar.updateSettings(mp.ScaleBarSettings(enabled: false));

    // You can also disable other UI elements if needed
    mapController?.logo.updateSettings(mp.LogoSettings(enabled: false));
    mapController?.attribution.updateSettings(
      mp.AttributionSettings(enabled: false),
    );

    // Configure location component with purple theme color
    mapController?.location.updateSettings(
      mp.LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        showAccuracyRing: true,
        // Set the purple color for the location puck
        puckBearingEnabled: true,
        // ignore: deprecated_member_use
        pulsingColor: const Color(0xFF590bbe).value.toInt(),
        pulsingMaxRadius: 45.0,
        accuracyRingColor: const Color(0xFF590bbe).value.toInt(),
        accuracyRingBorderColor: Colors.white.value.toInt(),
      ),
    );

    // Set initial camera position (default to a central location)
    mapController?.setCamera(
      mp.CameraOptions(
        zoom: 10,
        center: mp.Point(
          coordinates: mp.Position(-122.4194, 37.7749), // San Francisco default
        ),
      ),
    );
  }

  // Handle map tap events
  void _onMapTapped(mp.MapContentGestureContext context) {
    print(
      "Map tapped at: ${context.point.coordinates.lng}, ${context.point.coordinates.lat}",
    );

    // Check if user tapped near the current location puck
    if (_currentPosition != null) {
      _checkLocationPuckTap(context.point);
    }
  }

  // Check if the tap is near the current location puck
  void _checkLocationPuckTap(mp.Point tappedPoint) {
    if (_currentPosition == null || mapController == null) return;

    // Convert current position to screen coordinates
    mapController!
        .pixelForCoordinate(
          mp.Point(
            coordinates: mp.Position(
              _currentPosition!.longitude,
              _currentPosition!.latitude,
            ),
          ),
        )
        .then((screenPoint) {
          // Convert tapped point to screen coordinates
          mapController!.pixelForCoordinate(tappedPoint).then((
            tappedScreenPoint,
          ) {
            // Calculate distance between tap and location puck
            double distance = _calculateDistance(
              screenPoint.x,
              screenPoint.y,
              tappedScreenPoint.x,
              tappedScreenPoint.y,
            );

            // If tap is within 50 pixels of the location puck, navigate
            if (distance <= 50) {
              print("Location puck tapped!");
              _navigateToLocationDetails();
            }
          });
        });
  }

  // Calculate distance between two screen points
  double _calculateDistance(double x1, double y1, double x2, double y2) {
    return ((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)).abs();
  }

  // Navigate to location details page
  void _navigateToLocationDetails() {
    if (_currentPosition != null) {
      final position = mp.Position(
        _currentPosition!.longitude,
        _currentPosition!.latitude,
      );
      AppRouter.pushNamed(
        context,
        'report',
        queryParameters: {},
        extra: position,
      );
    }
  }

  Future<void> _showLocationPermissionDialog({
    required bool deniedForever,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Location Permission Required'),
          content: Text(
            deniedForever
                ? 'Location permission is permanently denied. Please enable it in the app settings to use location features.'
                : 'Location permission is required to use this feature. Please grant permission.',
          ),
          actions: [
            if (deniedForever)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  gl.Geolocator.openAppSettings();
                },
                child: Text('Open Settings'),
              )
            else
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await gl.Geolocator.requestPermission();
                  _setupPositionTracking();
                },
                child: Text('Grant Permission'),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _setupPositionTracking() async {
    try {
      bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Show system location services dialog instead
        bool serviceRequested = await gl.Geolocator.openLocationSettings();
        if (!serviceRequested) {
          setState(() {
            _locationError = 'Location services are disabled.';
          });
        }
        return;
      }

      gl.LocationPermission permission = await gl.Geolocator.checkPermission();
      if (permission == gl.LocationPermission.denied) {
        // Show the native permission dialog directly
        permission = await gl.Geolocator.requestPermission();

        // If still denied after request, show our custom dialog
        if (permission == gl.LocationPermission.denied) {
          setState(() {
            _locationError = 'Location permissions are denied';
          });
          _showLocationPermissionDialog(deniedForever: false);
          return;
        }
      }

      if (permission == gl.LocationPermission.deniedForever) {
        setState(() {
          _locationError = 'Location permissions are permanently denied';
        });
        _showLocationPermissionDialog(deniedForever: true);
        return;
      }

      // Permission granted, continue with tracking
      // Clear any previous error
      setState(() {
        _locationError = null;
      });

      gl.LocationSettings locationSettings = const gl.LocationSettings(
        accuracy: gl.LocationAccuracy.high,
        distanceFilter: 10,
      );

      userPositionStream?.cancel();
      userPositionStream = gl.Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen(
        (gl.Position position) {
          // Store the current position
          setState(() {
            _currentPosition = position;
          });

          if (_isMapInitialized && mapController != null) {
            mapController?.setCamera(
              mp.CameraOptions(
                zoom: 15,
                center: mp.Point(
                  coordinates: mp.Position(
                    position.longitude,
                    position.latitude,
                  ), // Fixed: longitude first, then latitude
                ),
              ),
            );
          }
        },
        onError: (error) {
          setState(() {
            _locationError = 'Location error: $error';
          });
        },
      );
    } catch (error) {
      setState(() {
        _locationError = 'Setup error: $error';
      });
    }
  }

  Future<void> centerOnCurrentLocation() async {
    print('🎯 Center button pressed - starting location process');

    if (!_isMapInitialized || mapController == null) {
      print(
        '❌ Map not ready: initialized=$_isMapInitialized, controller=${mapController != null}',
      );
      setState(() {
        _locationError = 'Map not ready yet';
      });
      _clearErrorAfterDelay();
      return;
    }

    try {
      print('📍 Getting current location...');

      // Check location services
      bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Try to open location settings first
        bool serviceRequested = await gl.Geolocator.openLocationSettings();
        if (!serviceRequested) {
          setState(() {
            _locationError = 'Location services are disabled.';
          });
          _clearErrorAfterDelay();
        }
        return;
      }

      gl.LocationPermission permission = await gl.Geolocator.checkPermission();
      if (permission == gl.LocationPermission.denied) {
        // Show the native permission dialog directly
        permission = await gl.Geolocator.requestPermission();

        // If still denied after request, then show our custom dialog
        if (permission == gl.LocationPermission.denied) {
          _showLocationPermissionDialog(deniedForever: false);
          setState(() {
            _locationError = 'Location permission required';
          });
          _clearErrorAfterDelay();
          return;
        }
      } else if (permission == gl.LocationPermission.deniedForever) {
        _showLocationPermissionDialog(deniedForever: true);
        setState(() {
          _locationError = 'Location permission required';
        });
        _clearErrorAfterDelay();
        return;
      }

      // Permission granted, continue with getting location
      print('✅ Getting precise location...');
      // Get current location
      gl.Position position = await gl.Geolocator.getCurrentPosition(
        locationSettings: const gl.LocationSettings(
          accuracy: gl.LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      // Update current position
      setState(() {
        _currentPosition = position;
      });

      print('📍 Location found: ${position.latitude}, ${position.longitude}');

      mp.Point currentLatLng = mp.Point(
        coordinates: mp.Position(position.longitude, position.latitude),
      );

      print('🎬 Moving camera to location...');
      // Use flyTo for smooth camera animation
      await mapController?.flyTo(
        mp.CameraOptions(zoom: 17.0, center: currentLatLng),
        mp.MapAnimationOptions(duration: 1500), // 1.5 second smooth animation
      );

      print('✅ Camera moved successfully');
      // Clear any error messages
      setState(() {
        _locationError = null;
      });
    } catch (error) {
      print('❌ Center location error: $error');
      setState(() {
        _locationError = 'Failed to get location: ${error.toString()}';
      });
      _clearErrorAfterDelay();
    }
  }

  void _clearErrorAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _locationError = null;
        });
      }
    });
  }
}

// Example destination page
