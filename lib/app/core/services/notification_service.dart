import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as log;

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_craft/app/utils/constants.dart';
import 'package:flutter_craft/flavors/build_config.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final Logger _logger = BuildConfig.instance.config.logger;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  static const String _appName = appName;

  static late NotificationDetails platformChannelSpecifics;

  NotificationService() {
    try {
      DarwinInitializationSettings iosPlatformChannelSettings =
          DarwinInitializationSettings(
        onDidReceiveLocalNotification: _showLocalNotification,
      );
      const DarwinNotificationDetails iosNotificationDetails =
          DarwinNotificationDetails();
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          const AndroidNotificationDetails(
        _appName,
        _appName,
        channelDescription: 'This is a $_appName notification channel',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        icon: '@mipmap/ic_launcher',
      );
      platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosNotificationDetails,
      );
      _localNotification.initialize(
        InitializationSettings(
          android: const AndroidInitializationSettings(
            '@mipmap/ic_launcher',
          ),
          iOS: iosPlatformChannelSettings,
        ),
        onDidReceiveNotificationResponse: _onNotificationActionTriggered,
        onDidReceiveBackgroundNotificationResponse:
            _onNotificationActionTriggered,
      );
    } catch (e) {
      _logger.i("NotificationServiceInitError: ${e.toString()}");
    }
  }

  Future<void> pushNotification(
    RemoteMessage message, [
    bool showNotification = false,
  ]) async {
    int id = DateTime.now().millisecondsSinceEpoch ~/ (1000 * 60);
    String? title = message.notification?.title;
    String? body = message.notification?.body;
    String payload = jsonEncode(message.data);
    if (title != null && body != null) {
      _showLocalNotification(
        id,
        title,
        body,
        payload,
        showNotification,
      );
    }
  }

  void _showLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload, [
    bool showNotification = false,
  ]) async {
    try {
      _logger.i("SHOWING NOTIFICATION\n$id-$title-$payload");
    } catch (error) {
      _logger.i("===========ERROR OCCURED============");
      _logger.i("||");
      _logger.i("SHOWING NOTIFICATION $id-$title-$payload");
      _logger.i("||");
      _logger.i("=======================");
    }
    try {
      Map<String, dynamic> data = jsonDecode(payload ?? "{}");

      if (showNotification) {
        await _localNotification.show(
          id,
          title,
          body,
          platformChannelSpecifics,
          payload: payload.toString(),
        );
      }
    } catch (exception, _) {
      _logger.i("ShowLocalNotificationError: ${exception.toString()}");
    }
  }

  Future<void> cancelAllNotification() async {
    try {
      await _localNotification.cancelAll();
    } catch (exception, _) {
      _logger.i("CancelAllNotificationError: ${exception.toString()}");
    }
  }

  Future<void> cancelNotification(int id) async {
    try {
      await _localNotification.cancel(id);
    } catch (exception, _) {
      _logger.i("CancelNotificationError: ${exception.toString()}");
    }
  }
}

@pragma('vm:entry-point')
void _onNotificationActionTriggered(
  NotificationResponse notificationResponse,
) {
  switch (notificationResponse.notificationResponseType) {
    case NotificationResponseType.selectedNotification:
      {
        _onSelectNotification(notificationResponse.payload);
        break;
      }
    case NotificationResponseType.selectedNotificationAction:
      break;
  }
}

void _onSelectNotification(String? payload) async {
  if (payload != null) {
    log.log("notification payload: $payload");
  }
}
  // // function to request notifications permissions
  // void requestNotificationPermission() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //       alert: true,
  //       announcement: true,
  //       badge: true,
  //       carPlay: true,
  //       criticalAlert: true,
  //       provisional: true,
  //       sound: true);
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     if (kDebugMode) {
  //       print('user granted permission');
  //     }
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     if (kDebugMode) {
  //       print('user granted provisional permission');
  //     }
  //   } else {
  //     AppSettings.openNotificationSettings();
  //     if (kDebugMode) {
  //       print('user denied permission');
  //     }
  //   }
  // }
  //
  // //function to initialise flutter local notification plugin to show notifications for android when app is active
  // void initLocalNotifications(
  //     BuildContext context, RemoteMessage message) async {
  //   var androidInitializationSettings =
  //   const AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  //   const IOSInitializationSettings iosInitializationSettings =
  //   IOSInitializationSettings(
  //     requestSoundPermission: false,
  //     requestBadgePermission: false,
  //     requestAlertPermission: false,
  //   );
  //
  //   var initializationSetting = InitializationSettings(
  //       android: androidInitializationSettings, iOS: iosInitializationSettings);
  //
  //   await _localNotification.initialize(initializationSetting,
  //       onSelectNotification: (payload) {
  //         // handle interaction when app is active for android
  //         handleMessage(context, message);
  //       });
  // }
  //
  // void firebaseFcmInit(BuildContext context) {
  //   FirebaseMessaging.onMessage.listen((message) {
  //     _logger.i("fcm foreground ${message.notification!.title.toString()}");
  //     _logger.i("fcm foreground ${message.notification!.body.toString()}");
  //
  //     //show notifications when app is active
  //     if (Platform.isAndroid) {
  //       //calling this function to handle internation
  //       initLocalNotifications(context, message);
  //       showNotification(message);
  //     } else {
  //       showNotification(message);
  //     }
  //   });
  // }
  //
  // Future<String> _downloadAndSaveFile(String url, String fileName) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final String filePath = '${directory.path}/$fileName';
  //   final dio = Dio();
  //   await dio.download(url, filePath);
  //   return filePath;
  // }
  //
  // // function to show visible notification when app is active
  // Future<void> showNotification(RemoteMessage message) async {
  //   AndroidNotificationChannel channel = AndroidNotificationChannel(
  //       Random.secure().nextInt(100000).toString(), 'notification_channel_name',
  //       importance: Importance.max);
  //
  //   final String largeIconPath = await _downloadAndSaveFile(
  //       '${message.notification?.android?.imageUrl}', 'largeIcon');
  //   final String bigPicturePath = await _downloadAndSaveFile(
  //       '${message.notification?.android?.imageUrl}', 'bigPicture');
  //
  //   final BigPictureStyleInformation bigPictureStyleInformation =
  //   BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
  //       largeIcon: FilePathAndroidBitmap(largeIconPath),
  //       contentTitle: '${message.notification?.title}',
  //       htmlFormatContentTitle: true,
  //       summaryText: '${message.notification?.body}',
  //       htmlFormatSummaryText: true,
  //       hideExpandedLargeIcon: true);
  //
  //   AndroidNotificationDetails androidNotificationDetails =
  //   AndroidNotificationDetails(
  //       channel.id.toString(), channel.name.toString(),
  //       channelDescription: 'your channel description',
  //       importance: Importance.high,
  //       priority: Priority.high,
  //       ticker: 'ticker',
  //       styleInformation: bigPictureStyleInformation,
  //       largeIcon: FilePathAndroidBitmap(largeIconPath));
  //
  //   NotificationDetails notificationDetails =
  //   NotificationDetails(android: androidNotificationDetails);
  //
  //   Future.delayed(Duration.zero, () {
  //     _flutterLocalNotificationsPlugin.show(
  //         0,
  //         message.notification!.title.toString(),
  //         message.notification!.body.toString(),
  //         notificationDetails);
  //   });
  // }
  //
  // //function to get device token on which we will send the notifications
  // Future<String> getDeviceToken() async {
  //   String? token = await messaging.getToken();
  //   _logger.i("fcm device token $token");
  //   // send fcm token to server
  //   return token!;
  // }
  //
  //
  //
  // //handle tap on notification when app is in background or terminated
  // Future<void> setupInteractMessage(BuildContext context) async {
  //   // when app is terminated
  //   RemoteMessage? initialMessage =
  //   await FirebaseMessaging.instance.getInitialMessage();
  //
  //   if (initialMessage != null) {
  //     handleMessage(context, initialMessage);
  //   }
  //
  //   //when app ins background
  //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //     handleMessage(context, event);
  //   });
  // }
  //
  // void handleMessage(BuildContext context, RemoteMessage message) async {
  //   FcmNotification notification = FcmNotification(
  //       title: message.notification?.title ?? "",
  //       description: message.notification?.body ?? "",
  //       imagePath: message.notification?.android?.imageUrl,
  //       timestamp: DateTime.now(),
  //       isSeen: false);
  // }
  //
  // void initNotificationService(BuildContext context) {
  //   requestNotificationPermission();
  //   firebaseFcmInit(context);
  //   setupInteractMessage(context);
  //   getDeviceToken();
  //   // subscribeToTopic();
  // }
  //
  // Future<void> subscribeToTopic() async {
  //   String? topicName = "";
  //   await FirebaseMessaging.instance.subscribeToTopic(topicName ?? "AllUser");
  // }
