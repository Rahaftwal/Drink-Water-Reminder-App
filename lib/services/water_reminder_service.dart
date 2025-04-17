// Developer Information
// File: water_reminder_service.dart
// Description: Service for managing water intake reminders and tracking
// Author: Rahaf AL-Twal
// Date: 2025
// Version: 1.0.0

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class WaterReminderService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  late SharedPreferences _prefs;
  static const String _dailyProgressKey = 'daily_progress';
  static const String _lastResetDateKey = 'last_reset_date';

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    tz.initializeTimeZones();
    
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notifications.initialize(initSettings);
    await _checkAndResetDailyProgress();
  }

  Future<void> _checkAndResetDailyProgress() async {
    final lastResetDate = _prefs.getString(_lastResetDateKey);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastResetDate == null) {
      await _prefs.setString(_lastResetDateKey, today.toString());
      return;
    }

    final lastReset = DateTime.parse(lastResetDate);
    if (lastReset.isBefore(today)) {
      await _prefs.setInt(_dailyProgressKey, 0);
      await _prefs.setString(_lastResetDateKey, today.toString());
    }
  }

  Future<int> getDailyProgress() async {
    return _prefs.getInt(_dailyProgressKey) ?? 0;
  }

  Future<void> updateDailyProgress(int progress) async {
    await _prefs.setInt(_dailyProgressKey, progress);
  }

  Future<void> scheduleReminders(int timesPerDay) async {
    await _notifications.cancelAll();

    if (timesPerDay <= 0) return;

    final interval = 24 * 60 * 60 ~/ timesPerDay; // Convert to seconds
    final now = DateTime.now();
    final startTime = DateTime(now.year, now.month, now.day, 8, 0); // Start at 8 AM

    for (int i = 0; i < timesPerDay; i++) {
      final scheduledTime = startTime.add(Duration(seconds: interval * i));
      if (scheduledTime.isAfter(now)) {
        await _scheduleNotification(
          id: i,
          title: 'Time to Drink Water! 💧',
          body: 'Stay hydrated and drink a glass of water!',
          scheduledDate: scheduledTime,
        );
      }
    }
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'water_reminder',
          'Water Reminder',
          channelDescription: 'Reminders to drink water',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
} 