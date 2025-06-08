import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;

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
   mapController!.compass.updateSettings(
    mp.CompassSettings(enabled: false)
  );

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

    // Configure location component
    mapController?.location.updateSettings(
      mp.LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        showAccuracyRing: true,
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

  Future<void> _setupPositionTracking() async {
    try {
      bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationError = 'Location services are disabled.';
        });
        return;
      }

      gl.LocationPermission permission = await gl.Geolocator.checkPermission();
      if (permission == gl.LocationPermission.denied) {
        permission = await gl.Geolocator.requestPermission();
        if (permission == gl.LocationPermission.denied) {
          setState(() {
            _locationError = 'Location permissions are denied';
          });
          return;
        }
      }

      if (permission == gl.LocationPermission.deniedForever) {
        setState(() {
          _locationError = 'Location permissions are permanently denied';
        });
        return;
      }

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

      // Check location services and permissions
      bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('❌ Location services disabled');
        setState(() {
          _locationError = 'Location services are disabled.';
        });
        _clearErrorAfterDelay();
        return;
      }

      gl.LocationPermission permission = await gl.Geolocator.checkPermission();
      if (permission == gl.LocationPermission.denied ||
          permission == gl.LocationPermission.deniedForever) {
        print('❌ Location permission denied: $permission');
        setState(() {
          _locationError = 'Location permission required';
        });
        _clearErrorAfterDelay();
        return;
      }

      print('✅ Getting precise location...');
      // Get current location
      gl.Position position = await gl.Geolocator.getCurrentPosition(
        locationSettings: const gl.LocationSettings(
          accuracy: gl.LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

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
