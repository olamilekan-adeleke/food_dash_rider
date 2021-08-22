import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationMethods {
  // this class handle all notifications
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    log(message.data.toString());
    log('Handling a background message ${message.messageId}'.toString());
    log('back ground runing...'.toString());

    // Get.toNamed('/notification');
  }

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidInitializationSettings _initialzationSettingsAndriod =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static const InitializationSettings _initializationSettings =
      InitializationSettings(android: _initialzationSettingsAndriod);

  static Future<void> initNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _flutterLocalNotificationsPlugin.initialize(_initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final RemoteNotification? notification = message.notification;
      log(notification!.title.toString());
      log(notification.body.toString());
      final AndroidNotification? android = message.notification?.android;

      if (android != null) {
        _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              _channel.description,
              icon: android.smallIcon,
            ),
          ),
        );
      }
    });
  }

  static Future<void> subscribeToTopice(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeToTopice(String topic) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
