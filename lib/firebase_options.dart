// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYbCrLjwWRVd5wpti7JJQr3-2DfyKY0_8',
    appId: '1:58982095541:android:b4c3699de28b40dabdfcfc',
    messagingSenderId: '58982095541',
    projectId: 'pcsd-fb86c',
    databaseURL: 'https://pcsd-fb86c-default-rtdb.firebaseio.com',
    storageBucket: 'pcsd-fb86c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4cjEVf2yGN-qGf0Xz-7cQixzE72if3XY',
    appId: '1:58982095541:ios:e9dbe8c166f345e1bdfcfc',
    messagingSenderId: '58982095541',
    projectId: 'pcsd-fb86c',
    databaseURL: 'https://pcsd-fb86c-default-rtdb.firebaseio.com',
    storageBucket: 'pcsd-fb86c.appspot.com',
    androidClientId: '58982095541-lmgb1mrsvtmds7n8v02v7da9k3gaqtmi.apps.googleusercontent.com',
    iosClientId: '58982095541-uen0qipe1milvl4e0uu3cach03qj7u91.apps.googleusercontent.com',
    iosBundleId: 'com.example.pcsdApp',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCBfQUBKO6kqSlTby5jG5UEmkA_hzfBfHg',
    appId: '1:58982095541:web:7e5fb633942b8d2cbdfcfc',
    messagingSenderId: '58982095541',
    projectId: 'pcsd-fb86c',
    authDomain: 'pcsd-fb86c.firebaseapp.com',
    databaseURL: 'https://pcsd-fb86c-default-rtdb.firebaseio.com',
    storageBucket: 'pcsd-fb86c.appspot.com',
    measurementId: 'G-B32HKKBBRM',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4cjEVf2yGN-qGf0Xz-7cQixzE72if3XY',
    appId: '1:58982095541:ios:e9dbe8c166f345e1bdfcfc',
    messagingSenderId: '58982095541',
    projectId: 'pcsd-fb86c',
    databaseURL: 'https://pcsd-fb86c-default-rtdb.firebaseio.com',
    storageBucket: 'pcsd-fb86c.appspot.com',
    androidClientId: '58982095541-lmgb1mrsvtmds7n8v02v7da9k3gaqtmi.apps.googleusercontent.com',
    iosClientId: '58982095541-uen0qipe1milvl4e0uu3cach03qj7u91.apps.googleusercontent.com',
    iosBundleId: 'com.example.pcsdApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCBfQUBKO6kqSlTby5jG5UEmkA_hzfBfHg',
    appId: '1:58982095541:web:941c4af4f5e12a20bdfcfc',
    messagingSenderId: '58982095541',
    projectId: 'pcsd-fb86c',
    authDomain: 'pcsd-fb86c.firebaseapp.com',
    databaseURL: 'https://pcsd-fb86c-default-rtdb.firebaseio.com',
    storageBucket: 'pcsd-fb86c.appspot.com',
    measurementId: 'G-QBJRR1L2SG',
  );

}