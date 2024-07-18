import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:rock_weather/app/presentation/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences globalSharedPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) await FlutterDisplayMode.setHighRefreshRate();
  globalSharedPrefs = await SharedPreferences.getInstance();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Weather',
      theme: _setTheme(),
      home: const Home(),
    );
  }
}

ThemeData _setTheme() {
  return ThemeData.dark().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(
          allowEnterRouteSnapshotting: false,
        ),
      },
    ),
  );
}
