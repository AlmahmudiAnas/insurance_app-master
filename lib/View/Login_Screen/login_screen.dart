import 'package:flutter/material.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Signup_Screen/personal_info_screen.dart';
import 'package:insurance_app/View_Model/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String routeName = 'Auth screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  FocusNode emailfocusNode = FocusNode();

  FocusNode passfocusNode = FocusNode();

  LoginProvider loginProvider = LoginProvider();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 167, 201, 87),
                    Color.fromARGB(255, 56, 102, 65),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        width: size.width / 1.15,
                        height: size.height / 1.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              'images/insurancelogo.png',
                              scale: 1.3,
                            ),
                            SizedBox(height: size.height / 15),
                            MyTextField(
                              focusNode: emailfocusNode,
                              controller: _emailController,
                              text: 'Enter your e-mail',
                              icon: Icons.email_outlined,
                              isPassword: false,
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }

                                // Regular expression to validate email format
                                final emailRegex = RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: size.height / 50),
                            MyTextField(
                              focusNode: passfocusNode,
                              controller: _passwordController,
                              icon: Icons.lock_outline,
                              isPassword: true,
                              textInputType: TextInputType.text,
                              text: 'Enter your password',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }

                                // Define the criteria for a strong password
                                final minLength = 6;

                                // Check if the password meets the criteria
                                if (value.length < minLength) {
                                  return 'Password should be at least $minLength characters';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: size.height / 120),
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //       value:
                            //           context.watch<LoginProvider>().remeberMe,
                            //       onChanged: (bool? value) {
                            //         context
                            //             .read<LoginProvider>()
                            //             .changeRemeberMe(value);
                            //       },
                            //     ),
                            //     Text(
                            //       'Remeber me',
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //       ),
                            //     ),
                            //     SizedBox(width: size.width / 5.5),
                            //     Text(
                            //       'Forgot password',
                            //       style: TextStyle(
                            //         fontSize: 15,
                            //         color: MyColors.btnColor,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: size.height / 30),
                            context.watch<LoginProvider>().isloading
                                ? CircularProgressIndicator()
                                : MyButton(
                                    size: size,
                                    text: 'Sign in',
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        // Perform the desired actions
                                        await context
                                            .read<LoginProvider>()
                                            .login(
                                              _emailController.text,
                                              _passwordController.text,
                                              context,
                                            );
                                      } else {
                                        print('Please fill form correctly');
                                      }
                                    },
                                  ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              fontSize: size.width / 25,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PersonalInfoScreen.routeName);
                            },
                            child: Text(
                              'Sign up now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width / 25,
                                color: Colors.yellow,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
