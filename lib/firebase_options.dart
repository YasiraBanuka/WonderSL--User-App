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
    apiKey: 'AIzaSyCoO4UnOs0ZAaDgT4GpezaMZwraL_yosBU',
    appId: '1:100508084164:web:8b859cf3331b30b93ae691',
    messagingSenderId: '100508084164',
    projectId: 'wondersl-fbea3',
    authDomain: 'wondersl-fbea3.firebaseapp.com',
    databaseURL: 'https://wondersl-fbea3-default-rtdb.firebaseio.com',
    storageBucket: 'wondersl-fbea3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2y8QEwF-zDRUC6AtQ_Zjd4WCMH0wfDoo',
    appId: '1:100508084164:android:70f938120064476e3ae691',
    messagingSenderId: '100508084164',
    projectId: 'wondersl-fbea3',
    databaseURL: 'https://wondersl-fbea3-default-rtdb.firebaseio.com',
    storageBucket: 'wondersl-fbea3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuAKRwrdthlq5LR9EaO_mTWw75dHF3Dds',
    appId: '1:100508084164:ios:ddafb4cfbeb445163ae691',
    messagingSenderId: '100508084164',
    projectId: 'wondersl-fbea3',
    databaseURL: 'https://wondersl-fbea3-default-rtdb.firebaseio.com',
    storageBucket: 'wondersl-fbea3.appspot.com',
    iosBundleId: 'com.example.chatBot',
  );
}