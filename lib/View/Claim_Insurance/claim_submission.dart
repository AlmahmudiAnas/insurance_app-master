import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Model/companies_model.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_drawer.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Submissions/my_submissions.dart';
import 'package:insurance_app/View_Model/claims_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';

class ClaimSubmission extends StatefulWidget {
  const ClaimSubmission({super.key});
  static String routeName = 'Claim submission';

  @override
  State<ClaimSubmission> createState() => _ClaimSubmissionState();
}

class _ClaimSubmissionState extends State<ClaimSubmission> {
  final _advancedDrawerController = AdvancedDrawerController();

  TextEditingController _policyNumberController = TextEditingController();
  TextEditingController _incidentDetailsController = TextEditingController();
  TextEditingController _locatinoController = TextEditingController();
  TextEditingController _claimAmountController = TextEditingController();

  FocusNode _policyNumberFocusNode = FocusNode();
  FocusNode _locationFocusNode = FocusNode();
  FocusNode _claimAmountFocusNode = FocusNode();
  FocusNode _incidentDetailsFocusNode = FocusNode();

  void _submitClaim() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    Provider.of<ClaimsProvider>(context, listen: false).isUploading = true;

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    Map<String, dynamic> userData = snapshot.data()!;
    String userName = userData['full name'];
    String userAddress = userData['address'];
    String userPhone = userData['phone'];

    final policyNumber = _policyNumberController.text;
    final incidentDetails = _incidentDetailsController.text;
    final location = _locatinoController.text;
    final claimAmount = _claimAmountController.text;
    final imageURL =
        Provider.of<ClaimsProvider>(context, listen: false).claimImageURL;

    if (policyNumber.isEmpty ||
        incidentDetails.isEmpty ||
        location.isEmpty ||
        claimAmount.isEmpty ||
        imageURL.isEmpty) {
      Provider.of<ClaimsProvider>(context, listen: false).isUploading = false;

      // Show an error message if any of the fields or image is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields and upload an image'),
        ),
      );
      return;
    }

    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context,
            listen: false);

    // Create a new claim submission document in the 'claim submissions' collection
    final claimSubmission = {
      'company name': newInsuranceProvider.selectedCompany?.companyName,
      'insurance type': newInsuranceProvider.selectedInsuranceType?.name,
      'uid': uid,
      'full name': userName,
      'address': userAddress,
      'phone': userPhone,
      'policyNumber': policyNumber,
      'incidentDetails': incidentDetails,
      'location': location,
      'claimAmount': claimAmount,
      'imageURL': imageURL,
      'status': 'Pending',
    };

    // Add the claim submission to the 'claim submissions' collection
    // Replace 'claimSubmissions' with your actual collection name
    FirebaseFirestore.instance
        .collection('claimSubmissions')
        .add(claimSubmission);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Claim submitted successfully')),
    );

    // Clear the form fields and selected image
    _policyNumberController.clear();
    _incidentDetailsController.clear();
    _locatinoController.clear();
    _claimAmountController.clear();
    Provider.of<ClaimsProvider>(context, listen: false).clearClaimImage();
    Provider.of<ClaimsProvider>(context, listen: false).isUploading = false;
    Navigator.pushNamed(context, MySubmissionsScreen.routeName);
    Provider.of<NewInsuranceProviderButtonFunctions>(context, listen: false)
        .resetSelectedValues();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
    final companies = newInsuranceProvider.getCompaniesForInsuranceType();
    final insuranceList = newInsuranceProvider.getInsuranceType();
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade100, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: MyDrawer(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 167, 201, 87),
          title: Center(
            child: Text(
              'Submit Claim',
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
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                    color: Colors.black,
                  ),
                );
              },
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
                height: size.height * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Claim your Insurance',
                        style: GoogleFonts.acme(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      MyTextField(
                        focusNode: _policyNumberFocusNode,
                        controller: _policyNumberController,
                        icon: Icons.policy,
                        isPassword: false,
                        text: 'Policy Number',
                        textInputType: TextInputType.number,
                        validator: (value) {
                          return newInsuranceProvider
                              .validateEmpty(value.toString());
                        },
                      ),
                      SizedBox(height: 10.h),

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        value: newInsuranceProvider.selectedInsuranceType,
                        hint: Text('Choose an Insurance'),
                        onChanged: (InsuranceType? newValue) {
                          if (newValue != null) {
                            newInsuranceProvider
                                .setSelectedInsuranceType(newValue);
                          }
                        },
                        items: insuranceList.map((insuranceType) {
                          return DropdownMenuItem(
                            value: insuranceType,
                            child: Text(insuranceType.name),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: size.height * 0.02),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        value: newInsuranceProvider.selectedCompany,
                        hint: Text('Choose a Company'),
                        onChanged: (Company? value) {
                          if (value != null) {
                            newInsuranceProvider.setSelectedCompany(value);
                          }
                        },
                        items: companies.map((company) {
                          return DropdownMenuItem(
                            value: company,
                            child: Text(company.companyName),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10.h),

                      MyTextField(
                        focusNode: _incidentDetailsFocusNode,
                        controller: _incidentDetailsController,
                        icon: Icons.details,
                        isPassword: false,
                        text: 'Incident Details',
                        textInputType: TextInputType.text,
                        validator: (value) {
                          return newInsuranceProvider
                              .validateEmpty(value.toString());
                        },
                      ),
                      SizedBox(height: 10.h),
                      MyTextField(
                        focusNode: _locationFocusNode,
                        controller: _locatinoController,
                        icon: Icons.pin_drop_outlined,
                        isPassword: false,
                        text: 'Incident Location',
                        textInputType: TextInputType.text,
                        validator: (value) {
                          return newInsuranceProvider
                              .validateEmpty(value.toString());
                        },
                      ),
                      SizedBox(height: 10.h),
                      MyTextField(
                        focusNode: _claimAmountFocusNode,
                        controller: _claimAmountController,
                        icon: Icons.money,
                        isPassword: false,
                        text: 'Claim Amount',
                        textInputType: TextInputType.number,
                        validator: (value) {
                          return newInsuranceProvider
                              .validateEmpty(value.toString());
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Upload Supporting Documentation',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      // add upload button
                      context.watch<ClaimsProvider>().imageUploading
                          ? CircularProgressIndicator()
                          : InkWell(
                              onTap: () {
                                Provider.of<ClaimsProvider>(context,
                                        listen: false)
                                    .claimPickUploadImage();
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                height: size.height * 0.06,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 118, 200, 147),
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Center(
                                  child: Text(
                                    'Upload',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: size.height * 0.02),
                      MyButton(
                        size: size,
                        text: 'Send',
                        onPressed: () async {
                          try {
                            _submitClaim();
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
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

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
