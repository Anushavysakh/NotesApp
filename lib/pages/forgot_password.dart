import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Password resent link is sent"),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return  AlertDialog(
            content: Text(e.message.toString())
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade200,
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Enter email for password recovery ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            child: TextField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: buildInputDecoration('Email'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
              onPressed: () {
                passwordReset();
              },
              child: Text("Reset Password"),
              color: Colors.blue)
        ],
      ),
    );
  }
}
