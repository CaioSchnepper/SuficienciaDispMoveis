// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA-Y6PF6-1T1m0AqHGejaH2CVG2MioBk9s',
    appId: '1:61213605142:web:7cb62bfa81b3256a40e437',
    messagingSenderId: '61213605142',
    projectId: 'dispositivosmoveis-69',
    authDomain: 'dispositivosmoveis-69.firebaseapp.com',
    databaseURL: 'https://dispositivosmoveis-69-default-rtdb.firebaseio.com',
    storageBucket: 'dispositivosmoveis-69.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDazwXMN_nGa7_GHHZGCyNbBpY2q-WPIL4',
    appId: '1:61213605142:android:fbeb528120c19e9740e437',
    messagingSenderId: '61213605142',
    projectId: 'dispositivosmoveis-69',
    databaseURL: 'https://dispositivosmoveis-69-default-rtdb.firebaseio.com',
    storageBucket: 'dispositivosmoveis-69.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLSGBuTIyB-2djlwSkvOZXVbY5W9i4CCc',
    appId: '1:61213605142:ios:f3035d3f3e18488a40e437',
    messagingSenderId: '61213605142',
    projectId: 'dispositivosmoveis-69',
    databaseURL: 'https://dispositivosmoveis-69-default-rtdb.firebaseio.com',
    storageBucket: 'dispositivosmoveis-69.appspot.com',
    iosBundleId: 'com.example.utfpr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLSGBuTIyB-2djlwSkvOZXVbY5W9i4CCc',
    appId: '1:61213605142:ios:f3035d3f3e18488a40e437',
    messagingSenderId: '61213605142',
    projectId: 'dispositivosmoveis-69',
    databaseURL: 'https://dispositivosmoveis-69-default-rtdb.firebaseio.com',
    storageBucket: 'dispositivosmoveis-69.appspot.com',
    iosBundleId: 'com.example.utfpr',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-Y6PF6-1T1m0AqHGejaH2CVG2MioBk9s',
    appId: '1:61213605142:web:05232a67f5cddbbe40e437',
    messagingSenderId: '61213605142',
    projectId: 'dispositivosmoveis-69',
    authDomain: 'dispositivosmoveis-69.firebaseapp.com',
    databaseURL: 'https://dispositivosmoveis-69-default-rtdb.firebaseio.com',
    storageBucket: 'dispositivosmoveis-69.appspot.com',
  );
}
