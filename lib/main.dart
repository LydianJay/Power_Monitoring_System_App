import 'package:flutter/material.dart';
import 'package:power_monitoring_system/app.dart';
import 'package:window_manager/window_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:power_monitoring_system/credentials/credentials.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.setResizable(false);
  await Supabase.initialize(
    url: Credentials.url,
    anonKey: Credentials.key,
  );
  WindowOptions windowOptions = const WindowOptions(
      size: Size(1000, 600),
      maximumSize: Size(1000, 600),
      center: true,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      windowButtonVisibility: false,
      title: "Power Monitoring System");

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const App());
}
