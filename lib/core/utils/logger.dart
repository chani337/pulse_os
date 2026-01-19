import 'dart:developer' as developer;

class Logger {
  static void debug(String message, [String? tag]) {
    developer.log(message, name: tag ?? 'PulseOS');
  }

  static void info(String message, [String? tag]) {
    developer.log(message, name: tag ?? 'PulseOS', level: 800);
  }

  static void warning(String message, [String? tag]) {
    developer.log(message, name: tag ?? 'PulseOS', level: 900);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'PulseOS',
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
