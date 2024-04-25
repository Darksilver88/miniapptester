import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDvHNBPaovYZBjGxUEUhS4wESHlLVTd9mI",
            authDomain: "mini-app-tester-muuc3n.firebaseapp.com",
            projectId: "mini-app-tester-muuc3n",
            storageBucket: "mini-app-tester-muuc3n.appspot.com",
            messagingSenderId: "274952073029",
            appId: "1:274952073029:web:38bb2e6419156d5d20d82c"));
  } else {
    await Firebase.initializeApp();
  }
}
