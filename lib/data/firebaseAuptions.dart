import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeP3wPrjBXJiNtDyo9x_GF9hvk2jQC288',
    appId: '1:760743352428:android:f3ddf518cd8a47263d2049',
    messagingSenderId: '760743352428',
    projectId: 'monitorsleep',
    storageBucket: 'monitorsleep.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxCvXS-LlC75_AnAGQE-BziuPzxeNoTnI',
    appId: '1:1097136521592:android:2634884c524aa464a7088d',
    projectId: 'weserveu-flutter',
    storageBucket: 'weserveu-flutter.appspot.com',
    iosClientId: '269396250060-mq5bub98ef5gl08aggbbvid06f1he6dg.apps.googleusercontent.com',
    iosBundleId: 'com.weserveu.rent', messagingSenderId: '',
  );
}