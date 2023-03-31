import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessages{
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }
}