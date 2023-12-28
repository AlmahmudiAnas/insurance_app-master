import 'package:flutter/material.dart';
import 'package:insurance_app/View/Login_Screen/login_screen.dart';

class GetStartBtn extends StatelessWidget {
  const GetStartBtn({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, LoginScreen.routeName);
      },
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: size.width / 1.5,
        height: size.height / 13,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 106, 153, 78),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            'Get Started',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
