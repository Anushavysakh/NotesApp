
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/services/firebase_services.dart';
import 'package:notes_app/widgets/widget.dart';

import 'authentication/auth_page.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final background = "assets/background.jpg";
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final height = const SizedBox(height: 30,);

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage(background), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 120),
              child: const Text(
                'Create an Account',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 200),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(children: [
                          buildTextFieldUserName(_userName),height,
                          Form(
                            autovalidateMode: AutovalidateMode.always,
                            child: TextFormField(
                              validator: (value) =>
                                  EmailValidator.validate(value!)
                                      ? null
                                      : "invalid email",
                              autofocus: true,
                              style: TextStyle(color: Colors.black),
                              controller: _email,
                              decoration: buildInputDecoration('Email'),
                            ),
                          ),height,
                          buildTextFieldPassword(_password),height,
                          buildTextFieldConfirmPassword(_confirmPassword),height,
                          Container(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                                onPressed: () {
                                  AuthService.instance.signUp(_email.text, _password.text,
                                      _userName.text,_confirmPassword.text);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AuthPage(),
                                  ));
                                },
                                child: Text("SignUp")),
                          ),height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Already a member ? ",
                                style: TextStyle(fontSize: 17),
                              ),
                              GestureDetector(
                                  onTap: widget.showLoginPage,
                                  child: Text(
                                    " SignIn",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))
                            ],
                          ),
                        ]),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
