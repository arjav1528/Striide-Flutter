import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class PermissionUtils {
  /// Shows a dialog explaining why a permission is needed
  static Future<bool> _showPermissionDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? settingsMessage,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: true,
          builder:
              (context) => AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(settingsMessage ?? 'Continue'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  /// Handles the permission status and shows appropriate dialogs
  static Future<bool> _handlePermission({
    required BuildContext context,
    required ph.Permission permission,
    required String permissionName,
    required String explanationMessage,
  }) async {
    final status = await permission.status;

    if (status.isGranted || status.isLimited) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      final shouldOpenSettings = await _showPermissionDialog(
        context: context,
        title: '$permissionName Permission Required',
        message:
            '$permissionName permission is permanently denied. Please enable it in the app settings.',
        settingsMessage: 'Open Settings',
      );

      if (shouldOpenSettings) {
        await ph.openAppSettings();
      }
      return false;
    }

    if (status.isDenied) {
      final shouldRequest = await _showPermissionDialog(
        context: context,
        title: '$permissionName Permission Required',
        message: explanationMessage,
      );

      if (shouldRequest) {
        final newStatus = await permission.request();
        return newStatus.isGranted || newStatus.isLimited;
      }
      return false;
    }

    if (status.isRestricted) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$permissionName permission is restricted on this device.',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      return false;
    }

    return false;
  }

  /// Request storage permission
  static Future<bool> requestStoragePermission(BuildContext context) async {
    return _handlePermission(
      context: context,
      permission: ph.Permission.storage,
      permissionName: 'Storage',
      explanationMessage:
          'This app needs access to storage to save and manage files.',
    );
  }

  /// Request photos permission
  static Future<bool> requestPhotosPermission(BuildContext context) async {
    return _handlePermission(
      context: context,
      permission: ph.Permission.photos,
      permissionName: 'Photos',
      explanationMessage:
          'This app needs access to your photos to let you select and share images.',
    );
  }

  /// Request camera permission
  static Future<bool> requestCameraPermission(BuildContext context) async {
    return _handlePermission(
      context: context,
      permission: ph.Permission.camera,
      permissionName: 'Camera',
      explanationMessage:
          'This app needs access to your camera to take photos.',
    );
  }
}
