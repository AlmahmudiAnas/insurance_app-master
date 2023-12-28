import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Signup_Screen/id_screen.dart';
import 'package:insurance_app/View_Model/auth_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});
  static String routeName = 'Sign up Screen';

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreeenState();
}

class _PersonalInfoScreeenState extends State<PersonalInfoScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _placeOfBirthController = TextEditingController();

  FocusNode namefocusNode = FocusNode();
  FocusNode phoneNumberfocusNode = FocusNode();
  FocusNode addressfocusNode = FocusNode();
  FocusNode placeOfBirthfocusNode = FocusNode();

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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  width: size.width / 1.15,
                  height: size.height / 1.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SingleChildScrollView(
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
                            'First enter your personal info',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.width / 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: size.height / 40),
                          MyTextField(
                            focusNode: namefocusNode,
                            controller: _nameController,
                            icon: Icons.person,
                            isPassword: false,
                            textInputType: TextInputType.text,
                            text: 'Full Name',
                            validator: (value) {
                              return newInsuranceProvider
                                  .validateEmpty(value.toString());
                            },
                          ),
                          SizedBox(height: size.height / 50),
                          MyTextField(
                            focusNode: addressfocusNode,
                            controller: _addressController,
                            icon: Icons.location_city,
                            isPassword: false,
                            textInputType: TextInputType.text,
                            text: 'City',
                            validator: (value) {
                              return newInsuranceProvider
                                  .validateEmpty(value.toString());
                            },
                          ),
                          SizedBox(height: size.height / 50),
                          MyTextField(
                            focusNode: phoneNumberfocusNode,
                            controller: _phoneNumberController,
                            icon: Icons.phone,
                            isPassword: false,
                            textInputType: TextInputType.number,
                            text: 'PhoneNumber',
                            validator: (value) {
                              return newInsuranceProvider
                                  .validateEmpty(value.toString());
                            },
                          ),
                          SizedBox(height: size.height / 50),
                          MyTextField(
                            focusNode: placeOfBirthfocusNode,
                            controller: _placeOfBirthController,
                            icon: Icons.location_city_outlined,
                            isPassword: false,
                            textInputType: TextInputType.text,
                            text: 'Place of birth',
                            validator: (value) {
                              return newInsuranceProvider
                                  .validateEmpty(value.toString());
                            },
                          ),
                          SizedBox(height: size.height / 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Text(
                              //   'Select your date of birth',
                              //   style: TextStyle(
                              //     fontSize: 20,
                              //     color: SharedColor.white,
                              //   ),
                              // ),
                              Text(
                                'Select your date of birth',
                                style: GoogleFonts.aleo(
                                  fontSize: size.width / 25,
                                ),
                              ),

                              Container(
                                width: size.width * 0.3,
                                height: size.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 87, 248, 119),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(onPressed: () {
                                  context
                                      .read<LoginProvider>()
                                      .selectDate(context);
                                }, child: Consumer<LoginProvider>(
                                  builder: (context, dataClass, child) {
                                    return Text(
                                        '${dataClass.selectedDate.toLocal()}'
                                            .split(' ')[0]);
                                  },
                                )),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height / 50),
                          Row(
                            children: [
                              SizedBox(
                                width: 115,
                                height: 115,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: Provider.of<LoginProvider>(
                                                  context,
                                                  listen: false)
                                              .imageURL ==
                                          " "
                                      ? null
                                      : NetworkImage(context
                                          .watch<LoginProvider>()
                                          .imageURL),
                                  child:
                                      context.watch<LoginProvider>().imageURL ==
                                              " "
                                          ? Icon(
                                              Icons.add_a_photo,
                                              color: Colors.white,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                            )
                                          : null,
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
                                            "Upload image",
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
                                  MapEntry('name', _nameController.text),
                                  MapEntry('address', _addressController.text),
                                  MapEntry(
                                      'phone', _phoneNumberController.text),
                                  MapEntry('place of birth',
                                      _placeOfBirthController.text),
                                });
                                print(Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .userData);
                                Navigator.pushNamed(
                                    context, IdScreen.routeName);
                              } else {
                                print('Fill Form Correctly');
                              }
                            },
                          ),
                          SizedBox(height: 15),
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
