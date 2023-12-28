import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ClaimsProvider extends ChangeNotifier {
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  String imageURL = " ";
  String claimImageURL = " ";
  bool imageUploading = false;
  bool isUploading = false;

  void clearClaimImage() {
    imgXFile = null;
    notifyListeners();
  }

  void claimPickUploadImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    Reference ref =
        FirebaseStorage.instance.ref().child(path.basename(image!.path));
    try {
      imageUploading = true;
      notifyListeners();
      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        print(value);

        claimImageURL = value;
        imageUploading = false;
        notifyListeners();
        Fluttertoast.showToast(
            msg: "Image Uploaded Successfully!!",
            toastLength: Toast.LENGTH_LONG);
      });
    } catch (e) {
      print(e);
    }
  }
}
