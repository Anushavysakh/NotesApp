import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/pages/authentication/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> _firebaseMessagingBackgroundHandler(message)async {
  await Firebase.initializeApp();
  print('Handling a background message${message.messageId}');
}
Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final isLoggedIn = await getLoginState();
  runApp( MyApp(isLoggedIn: isLoggedIn,));
}

Future<bool> getLoginState() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isLoggedIn = pref.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

updateLoginStatus(bool loginStatus) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool('isLoggedIn',loginStatus) ;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required bool isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        fontFamily: 'Georgia',
        primarySwatch: Colors.blue,

      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}




