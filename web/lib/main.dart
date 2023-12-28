import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/provider.dart';
import 'Screens/home_screen.dart';
import 'Screens/login_screen.dart';

String? email;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCgibCGiS0dDYlc-ceo1WA5334Vr-HaKhI',
      appId: '1:943482281784:web:67cd9f8cdac686dfa32bcd',
      messagingSenderId: '943482281784',
      projectId: 'insurance-e7130',
    ),
  );
  SharedPreferences pref = await SharedPreferences.getInstance();
  email = pref.getString('email');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DashboardProvider>(
      create: (context) => DashboardProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        DashboardScreen.routeName: (context) => DashboardScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
