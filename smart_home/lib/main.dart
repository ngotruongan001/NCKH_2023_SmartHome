import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/modules/splash_page/StartSplashScreen.dart';
import 'package:smart_home/themes/theme_provider.dart';

import 'package:smart_home/viewmodel/DataProvider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);

}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child:  MyApp(),
    ),
  );

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
// This widget is the root of your application.

}

class _MyAppState extends State<MyApp> {
  final DatabaseReference _database = FirebaseDatabase().reference();
  late FirebaseMessaging _fcm;
  late String message;
  late String token;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {

      }
      context.read<DataProvider>().fetchApiMessage();
    });
    getToken();
    context.read<DataProvider>().fetchApiMessage();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: context.watch<ThemeProvider>().BackgroundColor,
        fontFamily: 'LeonSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: StartSplashScreen(),
    );
  }

  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    print("token $token");
    setState(() {
      token = token;
    });

    final DatabaseReference _database = FirebaseDatabase().reference();
    _database.child('fcm-token').set({"token": token});
  }
}