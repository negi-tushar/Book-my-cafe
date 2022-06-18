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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBq4OPhBVqlf4xGvS1olVxn4MFnogAlEos',
    appId: '1:617159606534:web:1f3901459d61a36e591e87',
    messagingSenderId: '617159606534',
    projectId: 'book-my-cafe',
    authDomain: 'book-my-cafe.firebaseapp.com',
    storageBucket: 'book-my-cafe.appspot.com',
    measurementId: 'G-WP7N074HV3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuh0l3O6UuK89clcmil0B9PUH2SFC2_6o',
    appId: '1:617159606534:android:a2c41bcfcb7f1f56591e87',
    messagingSenderId: '617159606534',
    projectId: 'book-my-cafe',
    storageBucket: 'book-my-cafe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC82MoIPFAz0YSAH_i03YHT9kV7TS2poOs',
    appId: '1:617159606534:ios:8221dea6aab7f422591e87',
    messagingSenderId: '617159606534',
    projectId: 'book-my-cafe',
    storageBucket: 'book-my-cafe.appspot.com',
    iosClientId:
        '617159606534-5moiqm0pu1o95tr8i06vrl9gqb8p8mos.apps.googleusercontent.com',
    iosBundleId: 'com.example.restroapp',
  );
}