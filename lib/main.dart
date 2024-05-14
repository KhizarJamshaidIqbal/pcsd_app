// import 'package:camera/camera.dart';
// ignore_for_file: unused_local_variable, unused_import, avoid_print

import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pcsd_app/Providers/languge_change_provider.dart';
import 'package:pcsd_app/Providers/theme_changer_provider.dart';
import 'package:pcsd_app/admin/share/admin_dashbord_screens.dart';
import 'package:pcsd_app/constants/ThemeData/navigationbar_theme.dart';
import 'package:pcsd_app/controllers/notification_service.dart';
import 'package:pcsd_app/user/features/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final navigatorKey = GlobalKey<NavigatorState>();
List<CameraDescription>? cameras;
bool? seenOnboard;

//For Notifications
// function to listen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received in background...");
  }
}

// // to handle notification on foreground on web platform
void showNotification({required String title, required String body}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Ok"),
        ),
      ],
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Flutter fire Initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //TODO: load camera
  cameras = await availableCameras();

  // TODO: load onboard for the first time only
  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false;

  //TODO: Change App Language
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('langugeCode') ?? '';


  //TODO: Notification Service

  // initialize firebase messaging
  await PushNotifications.requestNotificationPermission();

  // initialize local notifications
  // dont use local notifications for web platform
  if (!kIsWeb) {
    await PushNotifications.localNotiInit();
  }

  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
      );
    }
  });

  // to handle foreground notifications

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      if (kIsWeb) {
        showNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
        );
      } else {
        PushNotifications.showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: payloadData);
      }
    }
  });

  // for handling in terminated state

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
      );
    });
  }

  //App Start
  runApp(
    MyApp(
      local: languageCode,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String local;
  const MyApp({super.key, required this.local});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LangugeChangeProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeChanger(),
          ),
        ],
        child: Consumer<LangugeChangeProvider>(
          builder: (context, provider, child) {
            if (provider.languageCode == null) {
              provider.chageLanguge(
                  local.isEmpty ? const Locale('en') : Locale(local));
            }
            return MaterialApp(
              title: 'PCSD',
              theme: ThemeData(
                navigationBarTheme: buildNavigationBarThemeData(),
              ),
              locale: provider.languageCode ?? const Locale('en'),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('ur'), // Urdu
              ],
              navigatorKey: navigatorKey,
              home:  const AdminDashbordScreens(),
            );
          },
        ));
  }
}
