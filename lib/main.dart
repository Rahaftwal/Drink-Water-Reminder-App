// Developer Information
// File: main.dart
// Description: Main entry point of the application
// Author: Rahaf AL-Twal
// Date: 2025
// Version: 1.0.0

import 'package:flutter/material.dart';
import 'package:drink_water_reminder/screens/home_screen.dart';
import 'package:drink_water_reminder/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Water Reminder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
