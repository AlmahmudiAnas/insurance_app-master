import 'package:firebase_auth/firebase_auth.dart';

class User {
  String _email, _pass;
  FirebaseAuth _auth = FirebaseAuth.instance;

  User(
    this._email,
    this._pass,
  );

  // @override
  // String toString() {
  //   return 'user{_fullName: $_fullName, _email: $_email, _pass: $_pass, _nationalNum: $_nationalNum, _phoneNum: $_phoneNum}';
  // }

  // String get fullName => _fullName;

  // set fullName(String value) {
  //   _fullName = value;
  // }

  get email => _email;

  // get phoneNum => _phoneNum;

  // set phoneNum(value) {
  //   _phoneNum = value;
  // }

  // int get nationalNum => _nationalNum;

  // set nationalNum(int value) {
  //   _nationalNum = value;
  // }

  String get pass => _pass;

  set pass(value) {
    _pass = value;
  }

  set email(value) {
    _email = value;
  }

  // String Signup() {
  //   if (_email.length < 1 && pass.length < 1) {
  //     if (_fullName.length > 1 && _nationalNum != 0) {
  //       _auth
  //           .createUserWithEmailAndPassword(email: email, password: pass)
  //           .then((value) {
  //         print(value);
  //         //  return "";
  //       });
  //       print("Account Created");
  //     }
  //   } else {
  //     print("Please fill ALL form");
  //   }
  //   return "Please fill ALL form";
  // }

  String SignIn() {
    if (_email.length > 5 || _pass.length > 5) {
      print("Successfull");
    }

    _auth
        .signInWithEmailAndPassword(email: _email, password: _pass)
        .then((value) => print(value));
    return "Successfull";
  }
}
