import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app/widgets/widget.dart';
import '../services/firebase_services.dart';
import '../services/google_auth.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final background = "assets/background.jpg";
  final googleSignIn = "assets/img.png";



  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(background), fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 35, top: 130),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 250),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        buildTextFieldEmail(_email),
                        const SizedBox(
                          height: 30,
                        ),
                        buildTextFieldPassword(_password),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const ForgotPassword();
                                }));
                              },
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff4c505b),
                                  fontSize: 18,
                                ),
                              )),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              AuthService.instance.signIn(_email.text.trim(), _password.text.trim());
                            },
                            child: const Text("Login")),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(children: [
                          const Text(
                            "-Or",
                            style: TextStyle(fontSize: 17),
                          ),const SizedBox(
                            height: 10,
                          ),

                          Container(padding: const EdgeInsets.only(right: 30,left: 40),
                            child: ElevatedButton(
                                onPressed: () {
                                  signInWithGoogle(context);
                                },
                                child: Row(
                                  children: const [
                                    Text(
                                      "Login with Google",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),SizedBox(
                                      width: 10.0,
                                    ),
                                    Image(image: AssetImage("assets/google.png"))
                                  ],
                                )),
                          )
                        ]),const SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Not registered?",
                              style: TextStyle(fontSize: 17),
                            ),
                            GestureDetector(
                                onTap: widget.showRegisterPage,
                                child: const Text(
                                  " SignUp",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
