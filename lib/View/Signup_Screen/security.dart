import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/HomeScreen/home_screen.dart';
import 'package:insurance_app/View_Model/auth_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});
  static String routeName = 'Security Screen';

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailfocusNode = FocusNode();
  FocusNode passwordfocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
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
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 80),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 120),
                  width: size.width / 1.15,
                  height: size.height / 1.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Create new account',
                          style: GoogleFonts.acme(
                            color: Colors.black,
                            fontSize: size.width / 15,
                          ),
                        ),
                        SizedBox(height: size.height / 50),
                        Text(
                          'Last enter your email and password',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.acme(
                            color: Colors.grey,
                            fontSize: size.width / 15,
                          ),
                        ),
                        SizedBox(height: size.height / 15),
                        MyTextField(
                          focusNode: emailfocusNode,
                          controller: _emailController,
                          icon: Icons.dialpad,
                          isPassword: false,
                          textInputType: TextInputType.emailAddress,
                          text: 'Email',
                          validator: (value) {
                            return newInsuranceProvider
                                .validateEmpty(value.toString());
                          },
                        ),
                        SizedBox(height: size.height / 50),
                        MyTextField(
                          focusNode: passwordfocusNode,
                          controller: _passwordController,
                          icon: Icons.location_city,
                          isPassword: true,
                          textInputType: TextInputType.text,
                          text: 'Password',
                          validator: (value) {
                            return newInsuranceProvider
                                .validateEmpty(value.toString());
                          },
                        ),
                        SizedBox(height: size.height / 30),
                        context.watch<LoginProvider>().isloading
                            ? CircularProgressIndicator()
                            : MyButton(
                                size: size,
                                text: 'Done',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Provider.of<LoginProvider>(context,
                                            listen: false)
                                        .userData
                                        .addEntries({
                                      MapEntry('email', _emailController.text),
                                      MapEntry(
                                          'password', _passwordController.text),
                                    });
                                    print(Provider.of<LoginProvider>(context,
                                            listen: false)
                                        .userData);
                                    await context
                                        .read<LoginProvider>()
                                        .createAccount();

                                    if (Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .signup ==
                                        true)
                                      Navigator.pushNamed(
                                          context, HomeScreen.routeName);
                                  } else {
                                    print('Fill Form Correctly');
                                  }
                                },
                              ),
                      ],
                    ),
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
