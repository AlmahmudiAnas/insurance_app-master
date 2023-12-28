import 'dart:io';
import 'package:insurance_app/View/HomeScreen/home_screen.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool remeberMe = false;
  DateTime selectedDate = DateTime.now();
  Map<String, dynamic> userData = {};
  bool isloading = false;
  bool signup = false;
  String? date;

  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  String imageURL = " ";
  String insuranceImageURL = " ";
  bool imageUploading = false;

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    Reference ref =
        FirebaseStorage.instance.ref().child(path.basename(image!.path));
    try {
      imageUploading = true;
      notifyListeners();
      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        print(value);

        imageURL = value;
        imageUploading = false;
        notifyListeners();
        Fluttertoast.showToast(
            msg: "Image Uploaded Successfully!!",
            toastLength: Toast.LENGTH_LONG);
      });
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void insurancePickUploadImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    Reference ref =
        FirebaseStorage.instance.ref().child(path.basename(image!.path));
    try {
      imageUploading = true;
      notifyListeners();
      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        print(value);

        insuranceImageURL = value;
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

  void isPasswordChanger(bool isPassword) {
    isPassword = !isPassword;
    notifyListeners();
  }

  void changeRemeberMe(bool? value) {
    remeberMe = !remeberMe;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      date = formattedDate.toString();
      userData.addEntries({
        MapEntry('date of birth', formattedDate),
      });
      notifyListeners();
    }
  }

  Future<User?> login(String email, String password, context) async {
    isloading = true;
    notifyListeners();
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      User? user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user != null) {
        print("Login Successful");
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('email', email);
        pref.setString(
            'uid', FirebaseAuth.instance.currentUser!.uid.toString());
        isloading = false;
        notifyListeners();
        Navigator.pushNamed(context, HomeScreen.routeName);
        return user;
      } else {
        // This block will be executed if signInWithEmailAndPassword succeeds
        // but returns a null user (unlikely).
        print("Login Failed: User is null");
        isloading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      // Handle login errors here
      print("Login Failed: $e");

      // You can display an error message to the user based on the exception
      // For example, if the exception message contains "invalid email", show
      // a message indicating that the email is invalid.
      String errorMessage =
          "Login failed. Please check your email and password.";

      // Show the error message to the user using a toast or dialog
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );

      isloading = false;
      notifyListeners();
      return null;
    }
  }

  Future<User?> createAccount() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    isloading = true;
    signup = false;
    notifyListeners();
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
              email: userData['email'], password: userData['password'])
          .catchError((err) {
        Fluttertoast.showToast(
          msg: "$err",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
        );
      });
      print("Account Created Succesfully");
      userCredential.user!.updateDisplayName(userData['name']);
      await _fireStore.collection('users').doc(_auth.currentUser!.uid).set({
        "full name": userData['name'],
        'email': userData['email'],
        'address': userData['address'],
        'phone': userData['phone'],
        'place of birth': userData['place of birth'],
        'date of birth': date,
        'passport number': userData['passport number'],
        'nationality': userData['nationality'],
        'sex': userData['sex'],
        'imageUrl': imageURL,
        "uid": _auth.currentUser!.uid,
      });
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('name', userData['name']);
      pref.setString('email', userData['email']);
      pref.setString('phone', userData['phone']);
      pref.setString('address', userData['address']);
      pref.setString('place of birth', userData['place of birth']);
      pref.setString('date of birth', date.toString());
      pref.setString('passport number', userData['passport number']);
      pref.setString('nationality', userData['nationality']);
      pref.setString('sex', userData['sex']);
      pref.setString('uid', FirebaseAuth.instance.currentUser!.uid.toString());
      isloading = false;
      signup = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 2));
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
