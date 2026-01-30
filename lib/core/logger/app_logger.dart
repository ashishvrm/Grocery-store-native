import 'dart:developer' as dev;
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppLogger {
  AppLogger._();

  static File? _logFile;

  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/app_log.txt');
    if (!await _logFile!.exists()) {
      await _logFile!.create(recursive: true);
    }
    info('Logger initialized at ${_logFile!.path}');
  }

  static void info(String message) => _log('INFO', message);

  static void warn(String message) => _log('WARN', message);

  static void error(String message) => _log('ERROR', message);

  static void _log(String level, String message) {
    final timestamp = DateTime.now().toIso8601String();
    final formatted = '[$timestamp][$level] $message';
    dev.log(formatted, name: 'APP_LOG');
    _logFile?.writeAsStringSync('$formatted\n', mode: FileMode.append);
  }
}
