import 'package:striide_flutter/core/utils/logger.dart';

/// Logger Demo - Showcases the enhanced visual logging capabilities
class LoggerDemo {
  static void runDemo() {
    // Configuration examples
    AppLogger.setUseColors(true);
    AppLogger.setUseEmojis(true);
    AppLogger.setShowTimestamp(true);

    // Banner example
    AppLogger.banner('STRIIDE APP STARTED');

    // Basic logging levels
    AppLogger.debug(
      'Debug message - for detailed information during development',
    );
    AppLogger.info('Info message - general application information');
    AppLogger.success('Success message - operation completed successfully');
    AppLogger.warning('Warning message - something might need attention');
    AppLogger.error('Error message - something went wrong');
    AppLogger.critical(
      'Critical message - serious error that needs immediate attention',
    );

    AppLogger.separator('BASIC LOGGING DEMO');

    // Network logging examples
    AppLogger.network(
      'GET',
      'https://api.striide.com/users/profile',
      statusCode: 200,
      duration: Duration(milliseconds: 245),
      headers: {
        'Authorization': 'Bearer ***token***',
        'Content-Type': 'application/json',
      },
      response:
          '{"id": "user123", "name": "John Doe", "email": "john@example.com"}',
    );

    AppLogger.network(
      'POST',
      'https://api.striide.com/auth/login',
      statusCode: 401,
      duration: Duration(milliseconds: 1500),
      response: '{"error": "Invalid credentials"}',
    );

    AppLogger.separator('NETWORK LOGGING DEMO');

    // User action logging
    AppLogger.userAction(
      'Button Clicked',
      screen: 'HomeScreen',
      data: {
        'button_id': 'login_button',
        'timestamp': DateTime.now().toIso8601String(),
        'user_id': 'user123',
      },
    );

    AppLogger.userAction(
      'Form Submitted',
      screen: 'ProfileScreen',
      data: {
        'form_type': 'profile_update',
        'fields_changed': ['name', 'email'],
        'validation_errors': 0,
      },
    );

    AppLogger.separator('USER ACTION DEMO');

    // Navigation logging
    AppLogger.navigation(
      'SplashScreen',
      'HomeScreen',
      arguments: {
        'user_id': 'user123',
        'session_token': '***token***',
        'theme': 'dark',
      },
    );

    AppLogger.navigation('HomeScreen', 'ProfileScreen');

    AppLogger.separator('NAVIGATION DEMO');

    // Authentication logging
    AppLogger.auth(
      'Login Successful',
      userId: 'user123',
      email: 'john@example.com',
      metadata: {
        'login_method': 'email',
        'device_type': 'mobile',
        'ip_address': '192.168.1.1',
        'user_agent': 'Striide Mobile App v1.0',
      },
    );

    AppLogger.auth(
      'Password Reset Requested',
      email: 'john@example.com',
      metadata: {'reset_token_sent': true, 'reset_method': 'email'},
    );

    AppLogger.separator('AUTHENTICATION DEMO');

    // Database logging
    AppLogger.database(
      'INSERT',
      'user_profiles',
      id: 'profile123',
      data: {
        'user_id': 'user123',
        'first_name': 'John',
        'last_name': 'Doe',
        'created_at': DateTime.now().toIso8601String(),
      },
    );

    AppLogger.database(
      'UPDATE',
      'user_settings',
      id: 'settings456',
      data: {
        'theme': 'dark',
        'notifications_enabled': true,
        'updated_at': DateTime.now().toIso8601String(),
      },
    );

    AppLogger.separator('DATABASE DEMO');

    // Performance logging
    AppLogger.performance(
      'Image Loading',
      Duration(milliseconds: 150),
      metrics: {
        'image_size': '2.3MB',
        'cache_hit': false,
        'compression_ratio': 0.65,
      },
    );

    AppLogger.performance(
      'API Response',
      Duration(milliseconds: 2500),
      metrics: {
        'endpoint': '/api/users',
        'payload_size': '45KB',
        'cache_miss': true,
      },
    );

    AppLogger.separator('PERFORMANCE DEMO');

    // Lifecycle logging
    AppLogger.lifecycle(
      'App Resumed',
      data: {
        'previous_state': 'paused',
        'duration_paused': '2 minutes',
        'background_tasks': 3,
      },
    );

    AppLogger.lifecycle(
      'App Backgrounded',
      data: {
        'current_screen': 'HomeScreen',
        'active_timers': 2,
        'pending_uploads': 1,
      },
    );

    AppLogger.separator('LIFECYCLE DEMO');

    // Memory logging
    AppLogger.memory(usedMB: 78, totalMB: 512, usagePercentage: 15.2);

    AppLogger.memory(usedMB: 245, totalMB: 512, usagePercentage: 47.8);

    AppLogger.separator('MEMORY DEMO');

    // Progress logging
    for (int i = 0; i <= 10; i++) {
      AppLogger.progress('File Upload', i, 10);
      // In real app, you'd have actual progress updates
    }

    AppLogger.separator('PROGRESS DEMO');

    // Box logging for structured information
    AppLogger.box([
      'Application Startup Complete',
      'Version: 1.0.0+1',
      'Build Mode: Debug',
      'Platform: ${_getCurrentPlatform()}',
      'Memory Usage: 78MB / 512MB',
      'Network Status: Connected',
    ]);

    AppLogger.separator('BOX DEMO');

    // Exception logging
    try {
      throw Exception('This is a demo exception');
    } catch (e, stackTrace) {
      AppLogger.exception(
        e as Exception,
        stackTrace,
        context: 'Logger Demo - Exception handling example',
        additionalData: {
          'user_action': 'running_logger_demo',
          'app_state': 'foreground',
          'network_available': true,
        },
      );
    }

    AppLogger.separator('EXCEPTION DEMO');

    // Custom separators
    AppLogger.separator('END OF DEMO', '─');
    AppLogger.separator('THANK YOU', '●');
    AppLogger.separator(); // Default separator

    // Final banner
    AppLogger.banner('DEMO COMPLETED SUCCESSFULLY!');
  }

  static String _getCurrentPlatform() {
    // This is a simplified example
    return 'Flutter Mobile';
  }
}
