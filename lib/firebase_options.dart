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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC-W0NqPeMJnyWU6AVq8w4k0MLM9Pqp6Z8',
    appId: '1:347820464523:web:eca995dd9bce365f10b78e',
    messagingSenderId: '347820464523',
    projectId: 'application-todo-da698',
    authDomain: 'application-todo-da698.firebaseapp.com',
    storageBucket: 'application-todo-da698.appspot.com',
    measurementId: 'G-6C20TME879',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDf9PIi1lx5kcGrs_JboYCwLUddbhZm7ms',
    appId: '1:347820464523:android:0569a03d8a525f1e10b78e',
    messagingSenderId: '347820464523',
    projectId: 'application-todo-da698',
    storageBucket: 'application-todo-da698.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDSUitDbjTZwnp93UnZtW85PndoS9yOmM',
    appId: '1:347820464523:ios:40baa3d4e633e66c10b78e',
    messagingSenderId: '347820464523',
    projectId: 'application-todo-da698',
    storageBucket: 'application-todo-da698.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );
}
