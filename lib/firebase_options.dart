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
    apiKey: 'AIzaSyBdLiG2SfMaRGvKlOe88_6W1brBtv6XwGs',
    appId: '1:135060147223:web:a8d5fb4f20891171446052',
    messagingSenderId: '135060147223',
    projectId: 'cruid-cloud',
    authDomain: 'cruid-cloud.firebaseapp.com',
    storageBucket: 'cruid-cloud.appspot.com',
    measurementId: 'G-S9E30M3JC0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6WYi7MEu40ql1NO5fy9Xo0LL4_otfZRI',
    appId: '1:135060147223:android:92ca6d86f570e788446052',
    messagingSenderId: '135060147223',
    projectId: 'cruid-cloud',
    storageBucket: 'cruid-cloud.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPaFGHK2CQu5iA5FfVGJE5SqAEkwBgyDk',
    appId: '1:135060147223:ios:88d20979e867d92e446052',
    messagingSenderId: '135060147223',
    projectId: 'cruid-cloud',
    storageBucket: 'cruid-cloud.appspot.com',
    iosClientId: '135060147223-n956r8vd528f7rogtmrf11cjeds7meo6.apps.googleusercontent.com',
    iosBundleId: 'com.example.cruidCloud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPaFGHK2CQu5iA5FfVGJE5SqAEkwBgyDk',
    appId: '1:135060147223:ios:88d20979e867d92e446052',
    messagingSenderId: '135060147223',
    projectId: 'cruid-cloud',
    storageBucket: 'cruid-cloud.appspot.com',
    iosClientId: '135060147223-n956r8vd528f7rogtmrf11cjeds7meo6.apps.googleusercontent.com',
    iosBundleId: 'com.example.cruidCloud',
  );
}
