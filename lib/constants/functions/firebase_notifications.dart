
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request permissions for iOS
    await _firebaseMessaging.requestPermission();

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in foreground!');
      _showNotification(message);
    });

    // Handle notification taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification caused app to open from background state!');
      // Handle notification tap here
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    // Handle background message
  }

  Future<void> _showNotification(RemoteMessage message) async {
    try {
      // Create notification details
      const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'com.expense.tracker', // Unique channel ID
        'notes-notification', // Channel name
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        // Additional configuration options
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      // Show notification
      await _flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title ?? 'ChatNotz', // Provide a default value
        message.notification?.body ?? 'ChatNotz', // Provide a default value
        platformChannelSpecifics,
        payload: message.data['payload'], // Optional: pass additional data
      );
    } catch (e) {
      // Handle exceptions or log errors
      log('Error showing notification: $e');
    }
  }
}