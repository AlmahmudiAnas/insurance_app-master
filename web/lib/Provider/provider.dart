import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/health_insurance.dart';
import '../Screens/home_screen.dart';

class DashboardProvider extends ChangeNotifier {
  Widget currentScreen = HealthInsuraceDB();

  bool isloading = false;

  String? companyName;

  void changeScreen(screen) {
    currentScreen = screen;
    notifyListeners();
  }

  Future<User?> login(String email, String password, context) async {
    isloading = true;
    notifyListeners();
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = (await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            // ignore: body_might_complete_normally_catch_error
            .catchError((err) {
      Fluttertoast.showToast(
          msg: "$err",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red);
      isloading = false;
      notifyListeners();
    }))
        .user;

    try {
      if (user != null) {
        print("Login Succesfull");
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('email', email);
        pref.setString(
            'uid', FirebaseAuth.instance.currentUser!.uid.toString());
        isloading = false;
        Navigator.pushNamed(context, DashboardScreen.routeName);
        notifyListeners();
        return user;
      } else {
        print("Login Failed");
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  void fetchUserCompanyName() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('Companies')
                .doc(userId)
                .get();

        if (snapshot.exists) {
          String? company = snapshot.data()?['company name'];
          companyName = company;
          notifyListeners();
        } else {
          // Document with the userId doesn't exist
          print('userId does not exist');
          return null;
        }
      } catch (e) {
        // Error occurred while fetching data
        print('Error fetching user company name: $e');
        return null;
      }
    } else {
      // User is not logged in
      print('user not logged in');
      return null;
    }
  }

  void claimStatusUpdate(String state, docID) {
    FirebaseFirestore.instance
        .collection('claimSubmissions')
        .doc(docID)
        .update({"status": state});
    notifyListeners();
  }
}
