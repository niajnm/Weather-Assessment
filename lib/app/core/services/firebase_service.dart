import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:weather_assesment/app/utils/constants.dart';
import 'package:weather_assesment/flavors/build_config.dart';
import 'package:weather_assesment/flavors/environment.dart';
import 'package:logger/logger.dart';

import 'notification_service.dart';

class FirebaseService {
  static final Logger _logger = BuildConfig.instance.config.logger;
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final NotificationService _notificationService = NotificationService();

  static Future<void> enableFirebase(Environment environment) async {
    Firebase.initializeApp(
            // After adding fire cli then un-commit options line.
            // options: DefaultFirebaseOptions.currentPlatform(environment),
            )
        .then((app) async {
      FirebaseMessaging.instance.requestPermission();
      _logger.i("Firebase initialized");
      await subscribeNotificationTopic(_getPlatformTopicName());
      await subscribeNotificationTopic(TOPIC_GLOBAL);
      await _configurePushNotification();
    });
  }

  static Future<void> subscribeNotificationTopic(String topic) async {
    _logger.d("Subscribing to topic $topic");
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeNotificationTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  static String _getPlatformTopicName() {
    return defaultTargetPlatform == TargetPlatform.android
        ? TOPIC_ANDROID
        : TOPIC_IOS;
  }

  static Future<void> _configurePushNotification() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    _logger.i("TOKEN - $fcmToken");
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      await _notificationService.pushNotification(message);
    });
    FirebaseMessaging.onMessage.listen((message) async {
      if (Platform.isAndroid) {
        await _notificationService.pushNotification(message, true);
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  NotificationService _notificationService = NotificationService();
  await _notificationService.pushNotification(message);
}
