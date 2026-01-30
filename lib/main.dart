import 'package:flutter/material.dart';
import 'app/app.dart';
import 'core/logger/app_logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLogger.init();
  AppLogger.info('App started');
  runApp(const GroceryStoreApp());
}
