// ignore_for_file: avoid_print, avoid_returning_null_for_void, avoid_function_literals_in_foreach_calls, unnecessary_null_comparison, unused_local_variable

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pcsd_app/controllers/crud_service.dart';
import 'package:pcsd_app/main.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';
import 'package:pcsd_app/user/features/splash/splash_screen.dart';

class PushNotifications {
  static final String channelId = Random().nextInt(1000000).toString();
  static const String channelName = 'PCSD Notifications channelId';
  //initialising firebase message plugin
  static final messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // initalize local notifications
  static Future localNotiInit() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );

    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    // request notification permissions for android 13 or above
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // firebase initialisation
  static Future firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }
      if (Platform.isIOS) {
        // forgroundMessage();
      }
      if (Platform.isAndroid) {
        localNotiInit();
        // showNotification(message);
      }
    });
  }

  // request notification permission
  static Future requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // get the fcm device token
  static Future getDeviceToken({int maxRetires = 3}) async {
    try {
      String? token;
      if (kIsWeb) {
        // get the device fcm token
        token = await messaging.getToken(
            // vapidKey:
            //     "BPA9r_00LYvGIV9GPqkpCwfIl3Es4IfbGqE9CSrm6oeYJslJNmicXYHyWOZQMPlORgfhG8RNGe7hIxmbLXuJ92k"
            );
        print("for web device token: $token");
      } else {
        // get the device fcm token
        token = await messaging.getToken();
        print("for android device token: $token");
      }
      saveTokentoFirestore(token: token!);
      return token;
    } catch (e) {
      print("failed to get device token");
      if (maxRetires > 0) {
        print("try after 10 sec");
        await Future.delayed(const Duration(seconds: 10));
        return getDeviceToken(maxRetires: maxRetires - 1);
      } else {
        return null;
      }
    }
  }

  static isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh:$event');
      }
    });
  }

  static saveTokentoFirestore({required String token}) async {
    bool isUserLoggedin = await FirebaseAuthServices.isLoggedIn();
    print("User is logged in $isUserLoggedin");
    if (isUserLoggedin) {
      await CRUDService.saveUserToken(token);
      print("save to firestore");
    }
    // also save if token changes
    messaging.onTokenRefresh.listen((event) async {
      if (isUserLoggedin) {
        await CRUDService.saveUserToken(token);
        print("save to firestore");
      } else {
        print("User is not logged in");
      }
    });
  }

  // on tap local notification in foreground
  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => SplashScreen(),
      ),
    );
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId,
      channelName,
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'),
      enableVibration: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      // Add your logo here
      // largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

// Send notification to all devices with registered tokens in Firestore
  static Future sendNotificationToAll({
    required String title,
    required String body,
    required String payload,
  }) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<String> tokens = [];
      querySnapshot.docs.forEach((doc) {
        if (doc.exists) {
          String token = (doc.data() as Map<String, dynamic>)['token'];
          if (token != null && token.isNotEmpty) {
            tokens.add(token);
          }
        }
      });

      if (tokens.isNotEmpty) {
        for (String token in tokens) {
          await _flutterLocalNotificationsPlugin.show(
            0,
            title,
            body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channelId,
                channelName,
                // 'channel_description',
                importance: Importance.high,
                priority: Priority.high,
              ),
            ),
            payload: payload,
          );
        }
        print('Notifications sent successfully to all devices.');
      } else {
        print('No tokens found in Firestore.');
      }
    } catch (e) {
      print('Failed to send notifications. Error: $e');
    }
  }
}
