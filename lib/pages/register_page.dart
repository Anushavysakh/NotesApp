import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:notes_app/services/repository/repository.dart';
import 'package:notes_app/widgets/widget.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../services/firebase_services.dart';
import 'authentication/auth_page.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final background = "assets/image1.jpg";
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final height = const SizedBox(
    height: 30,
  );
  File? _photo;

  final ImagePicker _picker = ImagePicker();

  String? userImage;

  @override
  void initState() {
    fetchProfileImage();
    // TODO: implement initState
    super.initState();
  }

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
              padding: const EdgeInsets.only(left: 35, top: 70),
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 120),
                child: Column(children: [
                  _photo != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: FileImage(_photo!),
                        )
                      : Center(
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                AssetImage('assets/user-picture.png'),
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              onPressed: () {
                                _showPicker(context);
                                print('UserImage: $userImage');
                              },
                              icon: const Icon(Icons.add_a_photo),
                              color: Colors.white,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35),
                    child: Column(children: [
                      buildTextFieldUserName(_userName),
                      height,
                      Form(
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          autofocus: true,
                          style: TextStyle(color: Colors.black),
                          controller: _email,
                          decoration: buildInputDecoration('Email'),
                        ),
                      ),
                      height,
                      buildTextFieldPassword(_password),
                      height,
                      buildTextFieldConfirmPassword(_confirmPassword),
                      height,
                      Container(
                        height: 40,
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              print(_photo.toString());
                              AuthService.instance.signUp(
                                _email.text,
                                _password.text,
                                _userName.text,
                                _confirmPassword.text,
                                userImage!,
                              );
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AuthPage(),
                              ));
                            },
                            child: Text("SignUp")),
                      ),
                      height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Already a member ? ",
                            style: TextStyle(fontSize: 17),
                          ),
                          GestureDetector(
                              onTap: widget.showLoginPage,
                              child: const Text(
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    const destination = 'file';

    final ref = firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .child(fileName);
    await ref.putFile(_photo!);
    ref.getDownloadURL().then((value) {
      final user = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'ImageUrl': value});
      setState(() {
        userImage = value;
      });
    });
  }
  Future<void> fetchProfileImage() async{
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {

    });
  }

}
