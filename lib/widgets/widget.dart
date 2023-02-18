

import 'package:flutter/material.dart';

import '../validation/my_validator.dart';

InputDecoration buildInputDecoration(String hintText) {
  return InputDecoration(hintStyle: TextStyle(color: Colors.grey.shade400),
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ));
}

TextField buildTextFieldUserName(userName) {
  return TextField(
    style: const TextStyle(color: Colors.black),
    keyboardType: TextInputType.name ,
    controller: userName,
    decoration: buildInputDecoration('User Name'),

  );
}




TextField buildTextFieldEmail(_email) {
  return TextField(

    onSubmitted: validateEmail(_email),
    style: const TextStyle(color: Colors.black),
    keyboardType: TextInputType.emailAddress,
    controller: _email,

   decoration: buildInputDecoration('Email address'),
  );
}

validateEmail(email) {
  MyValidator.emailValidator(email.toString());
}

TextField buildTextFieldPassword(_password) {
  return TextField(
    style: TextStyle(color: Colors.black),
    onSubmitted: validatePassword(_password),
    controller: _password,
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    decoration: buildInputDecoration('Password'),
  );
}

validatePassword(password) {
  MyValidator.passwordValidator(password.toString());
}

TextField buildTextFieldConfirmPassword(_confirmpassword) {
  return TextField(
    controller: _confirmpassword,
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    decoration: buildInputDecoration('Re-enter password'),
  );
}



