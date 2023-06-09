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
    apiKey: 'AIzaSyDnmOkjOMwnXyDXMoQtd7XiXixnUzHDH90',
    appId: '1:102357646672:web:610fd8a5057bb528258055',
    messagingSenderId: '102357646672',
    projectId: 'placestovisit-d4bdf',
    authDomain: 'placestovisit-d4bdf.firebaseapp.com',
    databaseURL: 'https://placestovisit-d4bdf-default-rtdb.firebaseio.com',
    storageBucket: 'placestovisit-d4bdf.appspot.com',
    measurementId: 'G-RM7918FHZW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYULsCXZ1_5j9gWfQYAft_GxPJWnOUF6Y',
    appId: '1:102357646672:android:846e3c188bed7ac5258055',
    messagingSenderId: '102357646672',
    projectId: 'placestovisit-d4bdf',
    databaseURL: 'https://placestovisit-d4bdf-default-rtdb.firebaseio.com',
    storageBucket: 'placestovisit-d4bdf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZscYu6eAY1FEeUhes38MaUvLHHiMtpGE',
    appId: '1:102357646672:ios:9c266d914db8293b258055',
    messagingSenderId: '102357646672',
    projectId: 'placestovisit-d4bdf',
    databaseURL: 'https://placestovisit-d4bdf-default-rtdb.firebaseio.com',
    storageBucket: 'placestovisit-d4bdf.appspot.com',
    iosClientId: '102357646672-vth11bpmpmemersuknp499t1vmr4vtjb.apps.googleusercontent.com',
    iosBundleId: 'com.example.placestovisit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZscYu6eAY1FEeUhes38MaUvLHHiMtpGE',
    appId: '1:102357646672:ios:9c266d914db8293b258055',
    messagingSenderId: '102357646672',
    projectId: 'placestovisit-d4bdf',
    databaseURL: 'https://placestovisit-d4bdf-default-rtdb.firebaseio.com',
    storageBucket: 'placestovisit-d4bdf.appspot.com',
    iosClientId: '102357646672-vth11bpmpmemersuknp499t1vmr4vtjb.apps.googleusercontent.com',
    iosBundleId: 'com.example.placestovisit',
  );
}
