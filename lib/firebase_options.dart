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
    apiKey: 'AIzaSyBz0xAVGgDU2QFAiKfF85bXhIM3Y13ynWc',
    appId: '1:540863649912:web:9d40ed21d416cd9396f58d',
    messagingSenderId: '540863649912',
    projectId: 'intellectopia',
    authDomain: 'intellectopia.firebaseapp.com',
    storageBucket: 'intellectopia.appspot.com',
    measurementId: 'G-80E4V5N97G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChZGME9HszwE98Vmn1Vnp2wAi3VsXF73k',
    appId: '1:540863649912:android:655781eccd13eeaf96f58d',
    messagingSenderId: '540863649912',
    projectId: 'intellectopia',
    storageBucket: 'intellectopia.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgzDiYck1dcfm8MjimWUzvi927BmFohuw',
    appId: '1:540863649912:ios:5b4c98400954985a96f58d',
    messagingSenderId: '540863649912',
    projectId: 'intellectopia',
    storageBucket: 'intellectopia.appspot.com',
    iosBundleId: 'intellectopia.com.intellectopia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgzDiYck1dcfm8MjimWUzvi927BmFohuw',
    appId: '1:540863649912:ios:9539848e55b02f3a96f58d',
    messagingSenderId: '540863649912',
    projectId: 'intellectopia',
    storageBucket: 'intellectopia.appspot.com',
    iosBundleId: 'intellectopia.com.intellectopia.RunnerTests',
  );
}
