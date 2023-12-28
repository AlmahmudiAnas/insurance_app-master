import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/View/HomeScreen/home_screen.dart';
import 'package:insurance_app/View/On_Boarding_Screen/on_boarding_screen.dart';
import 'package:insurance_app/View_Model/auth_provider.dart';
import 'package:insurance_app/View_Model/claims_provider.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:insurance_app/View_Model/onboarding_provider.dart';
import 'package:insurance_app/View_Model/payment_provider.dart';
import 'package:insurance_app/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? email;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  email = pref.getString('email');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<OnBoardingProvider>(
        create: (context) => OnBoardingProvider()),
    ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
    ),
    ChangeNotifierProvider<NewInsuranceProviderButtonFunctions>(
      create: (context) => NewInsuranceProviderButtonFunctions(),
    ),
    ChangeNotifierProvider<InsuranceProvider>(
      create: (context) => InsuranceProvider(),
    ),
    ChangeNotifierProvider<PaymentProvider>(
      create: (context) => PaymentProvider(),
    ),
    ChangeNotifierProvider<ClaimsProvider>(
      create: (context) => ClaimsProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'insurance app',
        debugShowMaterialGrid: false,
        routes: routes,
        initialRoute:
            email == null ? OnBoardingScreen.routeName : HomeScreen.routeName,
      ),
      designSize: const Size(340, 640),
    );
  }
}
