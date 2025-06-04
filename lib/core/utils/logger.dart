import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error, critical }

class AppLogger {
  static const String _tag = 'StriideApp';
  static bool _isEnabled = kDebugMode;

  // Enable or disable logging
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  // Debug level logging
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.debug, message, error, stackTrace);
  }

  // Info level logging
  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.info, message, error, stackTrace);
  }

  // Warning level logging
  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.warning, message, error, stackTrace);
  }

  // Error level logging
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }

  // Critical level logging
  static void critical(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _log(LogLevel.critical, message, error, stackTrace);
  }

  // Network logging
  static void network(
    String method,
    String url, {
    int? statusCode,
    String? response,
  }) {
    if (!_isEnabled) return;

    final message =
        'Network: $method $url${statusCode != null ? ' - $statusCode' : ''}';
    if (response != null) {
      debug('$message\nResponse: $response');
    } else {
      debug(message);
    }
  }

  // User action logging
  static void userAction(String action, {Map<String, dynamic>? data}) {
    if (!_isEnabled) return;

    String message = 'User Action: $action';
    if (data != null && data.isNotEmpty) {
      message += ' - Data: ${data.toString()}';
    }
    info(message);
  }

  // Navigation logging
  static void navigation(String from, String to) {
    if (!_isEnabled) return;
    info('Navigation: $from -> $to');
  }

  // Authentication logging
  static void auth(String action, {String? userId}) {
    if (!_isEnabled) return;
    String message = 'Auth: $action';
    if (userId != null) {
      message += ' - User: $userId';
    }
    info(message);
  }

  // Database operation logging
  static void database(String operation, String table, {String? id}) {
    if (!_isEnabled) return;
    String message = 'Database: $operation on $table';
    if (id != null) {
      message += ' - ID: $id';
    }
    debug(message);
  }

  // Performance logging
  static void performance(String operation, Duration duration) {
    if (!_isEnabled) return;
    info('Performance: $operation took ${duration.inMilliseconds}ms');
  }

  // Private logging method
  static void _log(
    LogLevel level,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (!_isEnabled) return;

    final timestamp = DateTime.now().toIso8601String();
    final levelString = level.name.toUpperCase();
    final formattedMessage = '[$timestamp] [$_tag] [$levelString] $message';

    // Use dart:developer log for better debugging experience
    developer.log(
      formattedMessage,
      name: _tag,
      error: error,
      stackTrace: stackTrace,
      level: _getLevelValue(level),
    );

    // Also print to console in debug mode
    if (kDebugMode) {
      print(formattedMessage);
      if (error != null) {
        print('Error: $error');
      }
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
  }

  // Get numeric level value for dart:developer
  static int _getLevelValue(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
      case LogLevel.critical:
        return 1200;
    }
  }

  // Log a separator for better readability
  static void separator([String? label]) {
    if (!_isEnabled) return;
    final separatorLine = '=' * 50;
    if (label != null) {
      debug('$separatorLine $label $separatorLine');
    } else {
      debug(separatorLine);
    }
  }

  // Log app lifecycle events
  static void lifecycle(String event) {
    if (!_isEnabled) return;
    info('App Lifecycle: $event');
  }

  // Log memory usage (if available)
  static void memory() {
    if (!_isEnabled) return;
    // This is a placeholder - actual memory usage would require platform-specific code
    debug('Memory usage logging (placeholder)');
  }
}
