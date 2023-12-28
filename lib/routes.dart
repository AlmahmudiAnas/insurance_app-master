import 'package:flutter/material.dart';
import 'package:insurance_app/View/About_us/about_us_screen.dart';
import 'package:insurance_app/View/Claim_Insurance/claim_submission.dart';
import 'package:insurance_app/View/HomeScreen/home_screen.dart';
import 'package:insurance_app/View/Login_Screen/login_screen.dart';
import 'package:insurance_app/View/New_Insurance/new_Insurance.dart';
import 'package:insurance_app/View/On_Boarding_Screen/on_boarding_screen.dart';
import 'package:insurance_app/View/PaymentScreen/payment_screen.dart';
import 'package:insurance_app/View/Profile_Screen/profile_screen.dart';
import 'package:insurance_app/View/Signup_Screen/id_screen.dart';
import 'package:insurance_app/View/Signup_Screen/personal_info_screen.dart';
import 'package:insurance_app/View/Signup_Screen/security.dart';
import 'package:insurance_app/View/Submissions/my_submissions.dart';

Map<String, WidgetBuilder> routes = {
  OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  PersonalInfoScreen.routeName: (context) => PersonalInfoScreen(),
  IdScreen.routeName: (context) => IdScreen(),
  SecurityScreen.routeName: (context) => SecurityScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  NewInsurance.routeName: (context) => NewInsurance(),
  PaymentScreen.routeName: (context) => PaymentScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ClaimSubmission.routeName: (context) => ClaimSubmission(),
  MySubmissionsScreen.routeName: (context) => MySubmissionsScreen(),
  AboutUsScreen.routeName: (context) => AboutUsScreen(),
};
