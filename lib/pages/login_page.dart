import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final background = "assets/background1.jpg";
  final googleSignIn = "assets/google.png";
  final asset = 'assets/login_background.jpg';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return portraitMode();
        } else {
          return landscapeMode();
        }
      },
    );
  }

  Widget portraitMode() {
    return Scaffold(
      body: Stack(
        children: [
          backgroundContainer(),
          Container(
            padding: const EdgeInsets.only(left: 30, top: 130),
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
                        // buildTextFieldEmail(_email),
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
                              AuthService.instance.signIn(
                                  _email.text.trim(), _password.text.trim());
                            },
                            child: const Text("Login")),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(children: [
                          const Text(
                            "-Or",
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          loginWithGoogleContainer(),
                        ]),
                        const SizedBox(
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

  Widget landscapeMode() {
    return Scaffold(
      body: Stack(
        children: [
          backgroundContainer(),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 50, top: 50),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
              SingleChildScrollView(
                child: Container( alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            // buildTextFieldEmail(_email),
                            buildTextFieldEmail(_email),
                            const SizedBox(
                              width: 30,
                            ),
                            buildTextFieldPassword(_password),
                            const SizedBox(
                              width: 10,
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
                                onPressed: () async{
                             await AuthService.instance.signIn(
                                      _email.text.trim(),
                                      _password.text.trim());
                                },
                                child: const Text("Login")),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(children: [
                              const Text(
                                "-Or",
                                style: TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              loginWithGoogleContainer()
                            ]),
                            const SizedBox(
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
        ],
      ),
    );
  }

  Widget backgroundContainer() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'assets/image1.jpg'.toString(),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget loginWithGoogleContainer() {
    return Container(alignment: Alignment.center,
      width: 280,
      child: ElevatedButton(
          onPressed: () {
            signInWithGoogle(context);
          },
          child: Row(
            children: [
              Image.asset(
                'assets/google.png'.toString(),
                width: 30,
                height: 30,
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Text(
                "Login with Google",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          )),
    );
  }
}
