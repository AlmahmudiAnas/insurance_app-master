import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Signup_Screen/security.dart';
import 'package:insurance_app/View_Model/auth_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';

class IdScreen extends StatefulWidget {
  const IdScreen({super.key});
  static String routeName = 'ID Screen';

  @override
  State<IdScreen> createState() => _IdScreenState();
}

class _IdScreenState extends State<IdScreen> {
  TextEditingController _passportNumberController = TextEditingController();
  TextEditingController _sexController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();

  FocusNode passoprtNumberfocusNode = FocusNode();
  FocusNode sexfocusNode = FocusNode();
  FocusNode nationalityfocusNode = FocusNode();

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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 80),
                  width: size.width / 1.15,
                  height: size.height / 1.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
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
                            'Second enter your ID info',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.acme(
                              color: Colors.grey,
                              fontSize: size.width / 15,
                            ),
                          ),
                          SizedBox(height: size.height / 15),
                          MyTextField(
                            focusNode: passoprtNumberfocusNode,
                            controller: _passportNumberController,
                            icon: Icons.dialpad,
                            isPassword: false,
                            textInputType: TextInputType.text,
                            text: 'Passport Number',
                            validator: (value) {
                              return newInsuranceProvider
                                  .validateEmpty(value.toString());
                            },
                          ),
                          SizedBox(height: size.height / 50),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Upload Passport',
                                style: GoogleFonts.acme(
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: size.width * 0.10),
                              context.watch<LoginProvider>().imageUploading ==
                                      true
                                  ? CircularProgressIndicator()
                                  : Container(
                                      height: size.height * 0.05,
                                      width: size.width * 0.40,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 40, 59, 164),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Provider.of<LoginProvider>(context,
                                                  listen: false)
                                              .pickUploadImage();
                                        },
                                        child: Center(
                                          child: Text(
                                            "Upload Passport",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: size.height / 50),
                          MyTextField(
                            focusNode: nationalityfocusNode,
                            controller: _nationalityController,
                            icon: Icons.location_city,
                            isPassword: false,
                            textInputType: TextInputType.text,
                            text: 'Nationality',
                            validator: (value) {
                              return newInsuranceProvider
                                  .validateEmpty(value.toString());
                            },
                          ),
                          SizedBox(height: size.height / 50),
                          MyTextField(
                            focusNode: sexfocusNode,
                            controller: _sexController,
                            icon: Icons.person,
                            isPassword: false,
                            textInputType: TextInputType.text,
                            text: 'Sex',
                            validator: (value) {
                              return newInsuranceProvider
                                  .validateEmpty(value.toString());
                            },
                          ),
                          SizedBox(height: size.height / 30),
                          MyButton(
                            size: size,
                            text: 'Next',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .userData
                                    .addEntries({
                                  MapEntry('passport number',
                                      _passportNumberController.text),
                                  MapEntry('nationality',
                                      _nationalityController.text),
                                  MapEntry('sex', _sexController.text),
                                });
                                print(Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .userData);
                                Navigator.pushNamed(
                                    context, SecurityScreen.routeName);
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
            ),
          ],
        ),
      ),
    );
  }
}
