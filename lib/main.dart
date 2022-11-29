import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/pages/authentication/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}




