import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgia3eso8hladZHzAPjkjf_PV6izZ9cCo',
    appId: '1:992373081256:android:1ed3bf091a5aa760c3ee9d',
    messagingSenderId: '992373081256',
    projectId: 'hotel-app-d248d',
    storageBucket: 'hotel-app-d248d.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCM4Ya-R84EKryJKswos7gdkPBnxrCb95s',
    appId: '1:992373081256:web:761c526ea8897f7bc3ee9d',
    messagingSenderId: '992373081256',
    projectId: 'hotel-app-d248d',
    authDomain: 'hotel-app-d248d.firebaseapp.com',
    storageBucket: 'hotel-app-d248d.appspot.com',
    measurementId: 'G-BBBHTS9HNF',
  );

}