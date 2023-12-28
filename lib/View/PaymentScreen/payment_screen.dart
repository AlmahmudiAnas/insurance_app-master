import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/colors.dart';
import 'package:insurance_app/View/Profile_Screen/profile_screen.dart';
import 'package:insurance_app/View_Model/auth_provider.dart';
import 'package:insurance_app/View_Model/payment_provider.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static String routeName = 'Payment Screen';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  FocusNode _NameOnCardFocusNode = FocusNode();
  FocusNode _CardNumberFocusNode = FocusNode();
  FocusNode _CardCVCNumberFocusNode = FocusNode();
  FocusNode _CardExpireMMFocusNode = FocusNode();
  FocusNode _CardExpireYYFocusNode = FocusNode();

  TextEditingController _NameOnCardController = TextEditingController();
  TextEditingController _CardNumberController = TextEditingController();
  TextEditingController _CardCVCNumberController = TextEditingController();
  TextEditingController _CardExpireMMController = TextEditingController();
  TextEditingController _CardExpireYYController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 167, 201, 87),
        title: Center(
          child: Text(
            'Card Info',
            style: GoogleFonts.acme(color: Colors.black),
          ),
        ),
        flexibleSpace: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 167, 201, 87),
                Color.fromARGB(255, 239, 239, 239),
              ],
              stops: [0.1, 0.9],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 167, 201, 87),
                  Color.fromARGB(255, 239, 239, 239),
                ],
                stops: [0.1, 0.9],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              width: size.width / 1.15,
              height: size.height * 0.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Enter Card holder name',
                      style: GoogleFonts.acme(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      focusNode: _NameOnCardFocusNode,
                      controller: _NameOnCardController,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 239, 239, 239),
                        filled: true,
                        hintText: 'Name on Card',
                        prefixIcon: Icon(Icons.payment),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.btnBorderColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Card Number',
                      style: GoogleFonts.acme(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      focusNode: _CardNumberFocusNode,
                      controller: _CardNumberController,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 239, 239, 239),
                        filled: true,
                        hintText: 'Card Number',
                        prefixIcon: Icon(Icons.payment),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.btnBorderColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Expire Date',
                      style: GoogleFonts.acme(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.26,
                          child: TextField(
                            focusNode: _CardExpireMMFocusNode,
                            controller: _CardExpireMMController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 239, 239, 239),
                              filled: true,
                              hintText: 'Month',
                              prefixIcon: Icon(Icons.date_range),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyColors.btnBorderColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.1),
                        SizedBox(
                          width: size.width * 0.26,
                          child: TextField(
                            focusNode: _CardExpireYYFocusNode,
                            controller: _CardExpireYYController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 239, 239, 239),
                              filled: true,
                              hintText: 'Year',
                              prefixIcon: Icon(Icons.payment),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyColors.btnBorderColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Enter the CVC Number',
                            style: GoogleFonts.acme(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.26,
                          child: TextField(
                            focusNode: _CardCVCNumberFocusNode,
                            controller: _CardCVCNumberController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 239, 239, 239),
                              filled: true,
                              hintText: 'CVC',
                              prefixIcon: Icon(Icons.payment),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyColors.btnBorderColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    MyButton(
                      size: size,
                      text: 'Add',
                      onPressed: () async {
                        try {
                          await Provider.of<PaymentProvider>(context,
                                  listen: false)
                              .addCardData(
                            Provider.of<LoginProvider>(context, listen: false)
                                .user!
                                .uid,
                            _NameOnCardController.text,
                            _CardNumberController.text,
                            _CardCVCNumberController.text,
                            _CardExpireMMController.text,
                          );
                        } catch (e) {
                          print(e);
                        }
                        Navigator.pushNamed(context, ProfileScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
