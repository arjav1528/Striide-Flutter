import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

enum LogLevel { debug, info, warning, error, critical, success }

class AppLogger {
  static const String _tag = '🚀 StriideApp';
  static bool _isEnabled = kDebugMode;
  static bool _useColors = true;
  static bool _useEmojis = true;
  static bool _showTimestamp = true;
  static bool _showStackTrace = true;

  // ANSI Color codes for terminal output
  static const String _reset = '\x1B[0m';
  static const String _bold = '\x1B[1m';
  static const String _underline = '\x1B[4m';

  // Colors
  static const String _black = '\x1B[30m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';
  static const String _white = '\x1B[37m';

  // Bright colors
  static const String _brightRed = '\x1B[91m';
  static const String _brightGreen = '\x1B[92m';
  static const String _brightYellow = '\x1B[93m';
  static const String _brightBlue = '\x1B[94m';
  static const String _brightMagenta = '\x1B[95m';
  static const String _brightCyan = '\x1B[96m';

  // Background colors
  static const String _bgRed = '\x1B[41m';
  static const String _bgGreen = '\x1B[42m';
  static const String _bgYellow = '\x1B[43m';
  static const String _bgBlue = '\x1B[44m';
  static const String _bgMagenta = '\x1B[45m';

  // Configuration methods
  static void setEnabled(bool enabled) => _isEnabled = enabled;
  static void setUseColors(bool useColors) => _useColors = useColors;
  static void setUseEmojis(bool useEmojis) => _useEmojis = useEmojis;
  static void setShowTimestamp(bool showTimestamp) =>
      _showTimestamp = showTimestamp;
  static void setShowStackTrace(bool showStackTrace) =>
      _showStackTrace = showStackTrace;

  // Main logging methods
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.debug, message, error, stackTrace);
  }

  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.info, message, error, stackTrace);
  }

  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.warning, message, error, stackTrace);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }

  static void critical(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _log(LogLevel.critical, message, error, stackTrace);
  }

  static void success(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.success, message, error, stackTrace);
  }

  // Enhanced specialized logging methods
  static void network(
    String method,
    String url, {
    int? statusCode,
    String? response,
    Duration? duration,
    Map<String, String>? headers,
  }) {
    if (!_isEnabled) return;

    final emoji = _useEmojis ? '🌐' : '';
    final statusEmoji = _getStatusEmoji(statusCode);

    final buffer = StringBuffer();
    buffer.writeln('${emoji} NETWORK REQUEST ${statusEmoji}');
    buffer.writeln('┌─ Method: ${_colorize(method, _brightCyan)}');
    buffer.writeln('├─ URL: ${_colorize(url, _blue)}');

    if (statusCode != null) {
      final statusColor = _getStatusColor(statusCode);
      buffer.writeln(
        '├─ Status: ${_colorize(statusCode.toString(), statusColor)}',
      );
    }

    if (duration != null) {
      final durationColor = duration.inMilliseconds > 1000 ? _red : _green;
      buffer.writeln(
        '├─ Duration: ${_colorize('${duration.inMilliseconds}ms', durationColor)}',
      );
    }

    if (headers != null && headers.isNotEmpty) {
      buffer.writeln('├─ Headers:');
      headers.forEach((key, value) {
        buffer.writeln(
          '│  ${_colorize(key, _cyan)}: ${_colorize(value, _white)}',
        );
      });
    }

    if (response != null) {
      final truncatedResponse =
          response.length > 200 ? '${response.substring(0, 200)}...' : response;
      buffer.writeln('└─ Response: ${_colorize(truncatedResponse, _yellow)}');
    } else {
      buffer.writeln('└─ End');
    }

    final level =
        (statusCode != null && statusCode >= 400)
            ? LogLevel.error
            : LogLevel.info;
    _log(level, buffer.toString());
  }

  static void userAction(
    String action, {
    Map<String, dynamic>? data,
    String? screen,
  }) {
    if (!_isEnabled) return;

    final emoji = _useEmojis ? '👤' : '';
    final buffer = StringBuffer();
    buffer.writeln('${emoji} USER ACTION');
    buffer.writeln('┌─ Action: ${_colorize(action, _brightGreen)}');

    if (screen != null) {
      buffer.writeln('├─ Screen: ${_colorize(screen, _blue)}');
    }

    if (data != null && data.isNotEmpty) {
      buffer.writeln('├─ Data:');
      data.forEach((key, value) {
        buffer.writeln(
          '│  ${_colorize(key, _cyan)}: ${_colorize(value.toString(), _white)}',
        );
      });
      buffer.writeln('└─ End');
    } else {
      buffer.writeln('└─ End');
    }

    _log(LogLevel.info, buffer.toString());
  }

  static void navigation(
    String from,
    String to, {
    Map<String, dynamic>? arguments,
  }) {
    if (!_isEnabled) return;

    final emoji = _useEmojis ? '🧭' : '';
    final buffer = StringBuffer();
    buffer.writeln('${emoji} NAVIGATION');
    buffer.writeln('┌─ From: ${_colorize(from, _red)}');
    buffer.writeln('├─ To: ${_colorize(to, _green)}');

    if (arguments != null && arguments.isNotEmpty) {
      buffer.writeln('├─ Arguments:');
      arguments.forEach((key, value) {
        buffer.writeln(
          '│  ${_colorize(key, _cyan)}: ${_colorize(value.toString(), _white)}',
        );
      });
      buffer.writeln('└─ End');
    } else {
      buffer.writeln('└─ End');
    }

    _log(LogLevel.info, buffer.toString());
  }

  static void auth(
    String action, {
    String? id,
    String? email,
    Map<String, dynamic>? metadata,
  }) {
    if (!_isEnabled) return;

    final emoji = _useEmojis ? '🔐' : '';
    final buffer = StringBuffer();
    buffer.writeln('${emoji} AUTHENTICATION');
    buffer.writeln('┌─ Action: ${_colorize(action, _brightMagenta)}');

    if (id != null) {
      buffer.writeln('├─ User ID: ${_colorize(id, _yellow)}');
    }

    if (email != null) {
      buffer.writeln('├─ Email: ${_colorize(email, _blue)}');
    }

    if (metadata != null && metadata.isNotEmpty) {
      buffer.writeln('├─ Metadata:');
      metadata.forEach((key, value) {
        buffer.writeln(
          '│  ${_colorize(key, _cyan)}: ${_colorize(value.toString(), _white)}',
        );
      });
      buffer.writeln('└─ End');
    } else {
      buffer.writeln('└─ End');
    }

    _log(LogLevel.info, buffer.toString());
  }

  static void database(
    String operation,
    String table, {
    String? id,
    Map<String, dynamic>? data,
  }) {
    if (!_isEnabled) return;

    final emoji = _useEmojis ? '🗄️' : '';
    final buffer = StringBuffer();
    buffer.writeln('${emoji} DATABASE');
    buffer.writeln(
      '┌─ Operation: ${_colorize(operation.toUpperCase(), _brightYellow)}',
    );
    buffer.writeln('├─ Table: ${_colorize(table, _magenta)}');

    if (id != null) {
      buffer.writeln('├─ ID: ${_colorize(id, _cyan)}');
    }

    if (data != null && data.isNotEmpty) {
      buffer.writeln('├─ Data:');
      data.forEach((key, value) {
        buffer.writeln(
          '│  ${_colorize(key, _cyan)}: ${_colorize(value.toString(), _white)}',
        );
      });
      buffer.writeln('└─ End');
    } else {
      buffer.writeln('└─ End');
    }

    _log(LogLevel.debug, buffer.toString());
  }

  static void performance(
    String operation,
    Duration duration, {
    Map<String, dynamic>? metrics,
  }) {
    if (!_isEnabled) return;

    final emoji = _useEmojis ? '⚡' : '';
    final durationMs = duration.inMilliseconds;
    final performanceLevel =
        durationMs > 1000
            ? '🐌'
            : durationMs > 500
            ? '🚶'
            : '🏃';
    final durationColor =
        durationMs > 1000
            ? _red
            : durationMs > 500
            ? _yellow
            : _green;

    final buffer = StringBuffer();
    buffer.writeln(
      '${emoji} PERFORMANCE ${_useEmojis ? performanceLevel : ''}',
    );
    buffer.writeln('┌─ Operation: ${_colorize(operation, _brightBlue)}');
    buffer.writeln(
      '├─ Duration: ${_colorize('${durationMs}ms', durationColor)}',
    );

    if (metrics != null && metrics.isNotEmpty) {
      buffer.writeln('├─ Metrics:');
      metrics.forEach((key, value) {
        buffer.writeln(
          '│  ${_colorize(key, _cyan)}: ${_colorize(value.toString(), _white)}',
        );
      });
      buffer.writeln('└─ End');
    } else {
      buffer.writeln('└─ End');
    }

    final level = durationMs > 1000 ? LogLevel.warning : LogLevel.info;
    _log(level, buffer.toString());
  }

  static void lifecycle(String event, {Map<String, dynamic>? data}) {
    if (!_isEnabled) return;

    final emoji = _useEmojis ? '🔄' : '';
    final buffer = StringBuffer();
    buffer.writeln('${emoji} APP LIFECYCLE');
    buffer.writeln('┌─ Event: ${_colorize(event, _brightCyan)}');

    if (data != null && data.isNotEmpty) {
      buffer.writeln('├─ Data:');
      data.forEach((key, value) {
        buffer.writeln(
          '│  ${_colorize(key, _cyan)}: ${_colorize(value.toString(), _white)}',
        );
      });
      buffer.writeln('└─ End');
    } else {
      buffer.writeln('└─ End');
    }

    _log(LogLevel.info, buffer.toString());
  }

  static void memory({int? usedMB, int? totalMB, double? usagePercentage}) {
    if (!_isEnabled) return;

    final emoji = _useEmojis ? '💾' : '';
    final buffer = StringBuffer();
    buffer.writeln('${emoji} MEMORY USAGE');

    if (usedMB != null) {
      final memoryColor =
          usedMB > 100
              ? _red
              : usedMB > 50
              ? _yellow
              : _green;
      buffer.writeln('┌─ Used: ${_colorize('${usedMB}MB', memoryColor)}');
    }

    if (totalMB != null) {
      buffer.writeln('├─ Total: ${_colorize('${totalMB}MB', _blue)}');
    }

    if (usagePercentage != null) {
      final percentColor =
          usagePercentage > 80
              ? _red
              : usagePercentage > 60
              ? _yellow
              : _green;
      buffer.writeln(
        '└─ Usage: ${_colorize('${usagePercentage.toStringAsFixed(1)}%', percentColor)}',
      );
    } else {
      buffer.writeln('└─ End');
    }

    final level =
        (usagePercentage != null && usagePercentage > 80)
            ? LogLevel.warning
            : LogLevel.debug;
    _log(level, buffer.toString());
  }

  // Enhanced separator methods
  static void separator([String? label, String style = '═']) {
    if (!_isEnabled) return;
    final length = 80;
    if (label != null) {
      final labelLength = label.length;
      final sideLength = (length - labelLength - 2) ~/ 2;
      final leftSide = style * sideLength;
      final rightSide = style * (length - labelLength - 2 - sideLength);
      final separatorLine = '$leftSide $label $rightSide';
      _log(LogLevel.debug, _colorize(separatorLine, _brightBlue));
    } else {
      final separatorLine = style * length;
      _log(LogLevel.debug, _colorize(separatorLine, _blue));
    }
  }

  static void banner(String text, {String style = '█'}) {
    if (!_isEnabled) return;
    final length = text.length + 4;
    final topBottom = style * length;
    final middle = '$style $text $style';

    _log(LogLevel.info, '');
    _log(LogLevel.info, _colorize(topBottom, _brightGreen));
    _log(LogLevel.info, _colorize(middle, _brightGreen));
    _log(LogLevel.info, _colorize(topBottom, _brightGreen));
    _log(LogLevel.info, '');
  }

  static void box(List<String> lines, {String style = '│'}) {
    if (!_isEnabled) return;
    final maxLength = lines
        .map((line) => line.length)
        .reduce((a, b) => a > b ? a : b);
    final width = maxLength + 4;

    final top = '┌${'─' * (width - 2)}┐';
    final bottom = '└${'─' * (width - 2)}┘';

    _log(LogLevel.info, _colorize(top, _cyan));
    for (final line in lines) {
      final padding = ' ' * (maxLength - line.length);
      _log(LogLevel.info, _colorize('$style $line$padding $style', _cyan));
    }
    _log(LogLevel.info, _colorize(bottom, _cyan));
  }

  // Progress logging
  static void progress(String operation, int current, int total) {
    if (!_isEnabled) return;
    final percentage = (current / total * 100).round();
    final progressBar = _createProgressBar(percentage);
    final emoji = _useEmojis ? '📊' : '';

    final message =
        '$emoji PROGRESS: $operation [$progressBar] $percentage% ($current/$total)';
    _log(LogLevel.info, message);
  }

  // Enhanced error logging with context
  static void exception(
    Exception exception,
    StackTrace stackTrace, {
    String? context,
    Map<String, dynamic>? additionalData,
  }) {
    if (!_isEnabled) return;

    final emoji = _useEmojis ? '💥' : '';
    final buffer = StringBuffer();
    buffer.writeln('${emoji} EXCEPTION CAUGHT');
    buffer.writeln(
      '┌─ Type: ${_colorize(exception.runtimeType.toString(), _brightRed)}',
    );
    buffer.writeln('├─ Message: ${_colorize(exception.toString(), _red)}');

    if (context != null) {
      buffer.writeln('├─ Context: ${_colorize(context, _yellow)}');
    }

    if (additionalData != null && additionalData.isNotEmpty) {
      buffer.writeln('├─ Additional Data:');
      additionalData.forEach((key, value) {
        buffer.writeln(
          '│  ${_colorize(key, _cyan)}: ${_colorize(value.toString(), _white)}',
        );
      });
    }

    buffer.writeln('└─ See stack trace below');

    _log(LogLevel.critical, buffer.toString(), exception, stackTrace);
  }

  // Private methods
  static void _log(
    LogLevel level,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (!_isEnabled) return;

    final timestamp = _showTimestamp ? _getFormattedTimestamp() : '';
    final levelInfo = _getLevelInfo(level);
    final emoji = levelInfo['emoji'] as String;
    final color = levelInfo['color'] as String;
    final levelName = levelInfo['name'] as String;

    final formattedLevel = _colorize('$emoji $levelName', color);
    final header =
        timestamp.isNotEmpty ? '$timestamp $formattedLevel' : formattedLevel;

    final formattedMessage = '$header\n$message';

    // Use dart:developer log for better debugging experience
    developer.log(
      formattedMessage,
      name: _tag,
      error: error,
      stackTrace: stackTrace,
      level: _getLevelValue(level),
    );

    // Also print to console in debug mode with enhanced formatting
    if (kDebugMode) {
      print(
        '${_colorize('┌────────────────────────────────────────', _brightBlue)}',
      );
      print(formattedMessage);

      if (error != null) {
        print('${_colorize('├─ ERROR DETAILS:', _red)}');
        print('${_colorize('│  $error', _brightRed)}');
      }

      if (stackTrace != null && _showStackTrace) {
        print('${_colorize('├─ STACK TRACE:', _red)}');
        final stackLines = stackTrace.toString().split('\n');
        for (int i = 0; i < stackLines.length && i < 10; i++) {
          print('${_colorize('│  ${stackLines[i]}', _yellow)}');
        }
        if (stackLines.length > 10) {
          print(
            '${_colorize('│  ... ${stackLines.length - 10} more lines', _yellow)}',
          );
        }
      }

      print(
        '${_colorize('└────────────────────────────────────────', _brightBlue)}',
      );
      print(''); // Empty line for separation
    }
  }

  static String _colorize(String text, String color) {
    if (!_useColors || !kDebugMode) return text;

    // Check if we're on a platform that supports ANSI colors
    try {
      if (Platform.isWindows) {
        // Windows Command Prompt might not support colors
        return text;
      }
    } catch (e) {
      // If Platform is not available (web), don't use colors
      return text;
    }

    return '$color$text$_reset';
  }

  static String _getFormattedTimestamp() {
    final now = DateTime.now();
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}.'
        '${now.millisecond.toString().padLeft(3, '0')}';
    return _colorize('[$timeStr]', _cyan);
  }

  static Map<String, dynamic> _getLevelInfo(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return {
          'emoji': _useEmojis ? '🐛' : '[DEBUG]',
          'color': _blue,
          'name': 'DEBUG',
        };
      case LogLevel.info:
        return {
          'emoji': _useEmojis ? 'ℹ️' : '[INFO]',
          'color': _green,
          'name': 'INFO',
        };
      case LogLevel.warning:
        return {
          'emoji': _useEmojis ? '⚠️' : '[WARN]',
          'color': _yellow,
          'name': 'WARN',
        };
      case LogLevel.error:
        return {
          'emoji': _useEmojis ? '❌' : '[ERROR]',
          'color': _red,
          'name': 'ERROR',
        };
      case LogLevel.critical:
        return {
          'emoji': _useEmojis ? '🚨' : '[CRITICAL]',
          'color': _bgRed + _white,
          'name': 'CRITICAL',
        };
      case LogLevel.success:
        return {
          'emoji': _useEmojis ? '✅' : '[SUCCESS]',
          'color': _brightGreen,
          'name': 'SUCCESS',
        };
    }
  }

  static int _getLevelValue(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.success:
        return 850;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
      case LogLevel.critical:
        return 1200;
    }
  }

  static String _getStatusEmoji(int? statusCode) {
    if (!_useEmojis || statusCode == null) return '';

    if (statusCode >= 200 && statusCode < 300) {
      return '✅';
    } else if (statusCode >= 300 && statusCode < 400) {
      return '↩️';
    } else if (statusCode >= 400 && statusCode < 500) {
      return '❌';
    } else if (statusCode >= 500) {
      return '💥';
    }
    return '❓';
  }

  static String _getStatusColor(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return _green;
    } else if (statusCode >= 300 && statusCode < 400) {
      return _yellow;
    } else if (statusCode >= 400 && statusCode < 500) {
      return _red;
    } else if (statusCode >= 500) {
      return _brightRed;
    }
    return _white;
  }

  static String _createProgressBar(int percentage) {
    const int barLength = 20;
    final int filledLength = (percentage / 100 * barLength).round();
    final String filled = '█' * filledLength;
    final String empty = '░' * (barLength - filledLength);
    return _colorize(filled, _green) + _colorize(empty, _white);
  }
}
