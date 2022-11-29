import 'package:flutter/material.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage(username, {Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState(name: 'name');
}

class _WelcomePageState extends State<WelcomePage> {

  String name;

  _WelcomePageState({required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $name",),
      ),
    );
  }

}
