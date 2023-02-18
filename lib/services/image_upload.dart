import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class ProfileImagePicker extends StatefulWidget {
//   ProfileImagePicker({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileImagePicker> createState() => _ProfileImagePickerState();
// }
//
// class _ProfileImagePickerState extends State<ProfileImagePicker> {
//   File? _photo;
//
//   final ImagePicker _picker = ImagePicker();
//
//
//   @override
//   void initState() {
//     uploadFile();
//   //  fetchImage();
//     // TODO: implement initState
//     super.initState();
//   }
//  // // Future<void> fetchImage() async {
//  //    await FirebaseFirestore.instance
//  //        .collection('users')
//  //        .doc(FirebaseAuth.instance.currentUser?.uid)
//  //        .get()
//  //        .then((snapshot) {
//  //      final data = snapshot.data();
//  //      setState(() {
//  //        userImage = data?['Image'];
//  //      });
//  //    });
//  //  }
//   @override
//   Widget build(BuildContext context) {
//     return userImage != null
//         ? CircleAvatar(
//             radius: 64,
//             backgroundImage: FileImage(_photo),
//           )
//         : Center(
//             child: CircleAvatar(
//               radius: 45,
//               backgroundImage: AssetImage('assets/user-picture.png'),
//               backgroundColor: Colors.grey,
//               child: IconButton(
//                 onPressed: () {
//                   _showPicker(context);
//                   print('UserImage');
//                 },
//                 icon: const Icon(Icons.add_a_photo),
//                 color: Colors.white,
//               ),
//             ),
//           );
//   }
//
//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: Wrap(
//                 children: <Widget>[
//                   ListTile(
//                       leading: const Icon(Icons.photo_library),
//                       title: const Text('Gallery'),
//                       onTap: () {
//                         imgFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   ListTile(
//                     leading: const Icon(Icons.photo_camera),
//                     title: const Text('Camera'),
//                     onTap: () {
//                       imgFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Future imgFromGallery() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _photo = File(pickedFile.path);
//         uploadFile();
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   Future imgFromCamera() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//
//     setState(() {
//       if (pickedFile != null) {
//         _photo = File(pickedFile.path);
//         uploadFile();
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   Future uploadFile() async {
//     if (_photo == null) return;
//     final fileName = basename(_photo!.path);
//     final destination = 'file/file';
//
//     final ref = firebase_storage.FirebaseStorage.instance
//         .ref(destination)
//         .child(fileName);
//     await ref.putFile(_photo!);
//     ref.getDownloadURL().then((value) {
//       FirebaseFirestore.instance
//           .collection("users")
//           .doc(FirebaseAuth.instance.currentUser?.uid)
//           .update({'Image': value});
//       setState(() {
//         _photo = value as File;
//       });
//     });
//   }
//
//
// }

class ImageUploads extends StatefulWidget {
  ImageUploads({Key? key}) : super(key: key);

  @override
  _ImageUploadsState createState() => _ImageUploadsState();
}

class _ImageUploadsState extends State<ImageUploads> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

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
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[

          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: _photo != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _photo!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
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
}
