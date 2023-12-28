import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/View/HomeScreen/home_screen.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

class HomePdfScreen extends StatefulWidget {
  const HomePdfScreen({
    Key? key,
    required this.fieldData,
  }) : super(key: key);

  final Map<String, dynamic> fieldData;

  @override
  State<HomePdfScreen> createState() => _HomePdfScreenState();
}

class _HomePdfScreenState extends State<HomePdfScreen> {
  String? pdfPath;

  @override
  void initState() {
    super.initState();
    generatePdf();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    final alNamaImage = pw.MemoryImage(
      (await rootBundle.load('images/2012177_logo_1531721978_n.png'))
          .buffer
          .asUint8List(),
    );

    final alBarakaImage = pw.MemoryImage(
      (await rootBundle.load('images/Al Baraka.png')).buffer.asUint8List(),
    );

    final qafelaImage = pw.MemoryImage(
      (await rootBundle.load('images/qafela_insurance.png'))
          .buffer
          .asUint8List(),
    );

    final alWathekaImage = pw.MemoryImage(
      (await rootBundle.load('images/ALWATHEKA.png')).buffer.asUint8List(),
    );

    // Load the signature image
    final signatureProvider = pw.MemoryImage(
      (await rootBundle.load('images/signature.png')).buffer.asUint8List(),
    );

    final alwathekaSigniture = pw.MemoryImage(
      (await rootBundle.load('images/alwatheka_signiture.png'))
          .buffer
          .asUint8List(),
    );

    final qafelaSigniture = pw.MemoryImage(
      (await rootBundle.load('images/Qafela_signiture.png'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  if (widget.fieldData['companyName'] == 'Company 1')
                    pw.Container(
                      margin: pw.EdgeInsets.only(right: 10, bottom: 10),
                      width: 150,
                      height: 100,
                      child: pw.Image(alNamaImage),
                    ),
                  if (widget.fieldData['companyName'] == 'Company 2')
                    pw.Container(
                      margin: pw.EdgeInsets.only(right: 10, bottom: 10),
                      width: 150,
                      height: 100,
                      child: pw.Image(alBarakaImage),
                    ),
                  if (widget.fieldData['companyName'] == 'Alwatheka')
                    pw.Container(
                      margin: pw.EdgeInsets.only(right: 10, bottom: 10),
                      width: 150,
                      height: 100,
                      child: pw.Image(alWathekaImage),
                    ),
                  if (widget.fieldData['companyName'] == 'Qafela')
                    pw.Container(
                      margin: pw.EdgeInsets.only(right: 10, bottom: 10),
                      width: 150,
                      height: 100,
                      child: pw.Image(qafelaImage),
                    ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    widget.fieldData['companyName'].toString(),
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    widget.fieldData['insuranceType'].toString(),
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'This insurance is issued to ${user!.displayName}. '
                    'The insured person is now covered by our company with the price of \$${widget.fieldData['insurance price']}. '
                    'And please take notice that this insurance starts at ${widget.fieldData['start date']}, and will end at ${widget.fieldData['expiration date']}.\n'
                    'Please find below the details of the insurance:',
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.Divider(),
                  pw.SizedBox(height: 20),
                  pw.Table.fromTextArray(
                    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    headers: ['Field', 'Value'],
                    data: [
                      [
                        'Property Owned or Rented',
                        widget.fieldData['houseOwned'].toString()
                      ],
                      [
                        'Type of Property',
                        widget.fieldData['propertyType'].toString()
                      ],
                      [
                        'How many stories',
                        widget.fieldData['numberOfStories'].toString()
                      ],
                      [
                        'Square Meter',
                        widget.fieldData['squareKillos'].toString()
                      ],
                      [
                        'People in the house',
                        widget.fieldData['livesInHome'].toString()
                      ],
                      [
                        'Property Condition',
                        widget.fieldData['exteriorInteriorCondition'].toString()
                      ],
                      [
                        'Construction Type',
                        widget.fieldData['constructionType'].toString()
                      ],
                      ['Used For', widget.fieldData['homeSafety'].toString()],
                      [
                        'Third Party insurance',
                        widget.fieldData['ThirdParty'].toString()
                      ],
                      if (widget.fieldData['ThirdParty'] == 'Yes')
                        [
                          'Beneficiary Name',
                          widget.fieldData['Beneficiary Name'].toString()
                        ],
                      if (widget.fieldData['ThirdParty'] == 'Yes')
                        [
                          'Relationship to Insured',
                          widget.fieldData['Relationship to Insured'].toString()
                        ],
                    ],
                    cellAlignments: {
                      0: pw.Alignment.centerLeft,
                      1: pw.Alignment.centerLeft,
                    },
                  ),
                  pw.SizedBox(height: 20),
                  pw.Divider(),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Thank you for using our services!',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.fieldData['companyName'] == 'Alwatheka')
                        pw.Align(
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Container(
                            margin: pw.EdgeInsets.only(right: 10, bottom: 10),
                            width: 150,
                            height: 100,
                            child: pw.Image(alwathekaSigniture),
                          ),
                        ),
                      if (widget.fieldData['companyName'] == 'Qafela')
                        pw.Align(
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Container(
                            margin: pw.EdgeInsets.only(right: 10, bottom: 10),
                            width: 150,
                            height: 100,
                            child: pw.Image(qafelaSigniture),
                          ),
                        ),
                      if (widget.fieldData['companyName'] != 'Alwatheka' &&
                          widget.fieldData['companyName'] != 'Qafela')
                        pw.Align(
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Container(
                            margin: pw.EdgeInsets.only(right: 10, bottom: 10),
                            width: 150,
                            height: 100,
                            child: pw.Image(signatureProvider),
                          ),
                        ),
                      pw.Align(
                        alignment: pw.Alignment.bottomLeft,
                        child: pw.Container(
                          margin: pw.EdgeInsets.only(left: 10, bottom: 10),
                          width: 100,
                          height: 100,
                          child: pw.BarcodeWidget(
                            barcode: pw.Barcode.qrCode(),
                            data: 'Your QR Code Data',
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Align(
                    alignment: pw.Alignment.bottomCenter,
                    child: pw.Text(
                      'Your insurance number is: ${widget.fieldData['insurance number']}',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final outputFile = File('${output.path}/filled_form.pdf');
    await outputFile.writeAsBytes(await pdf.save());

    setState(() {
      pdfPath = outputFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 167, 201, 87),
        title: Text(
          'Review insurance',
          style: GoogleFonts.acme(color: Colors.black),
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
              height: size.height / 1.1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.4,
                      child: InsuDetails(),
                    ),
                    Container(
                      width: size.width,
                      height: size.height * 0.6,
                      child: pdfPath != null
                          ? PDFView(
                              filePath: pdfPath!,
                            )
                          : Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(height: size.height * 0.02),
                    context.watch<InsuranceProvider>().isLoading
                        ? CircularProgressIndicator()
                        : MyButton(
                            size: size,
                            text: 'Submit',
                            onPressed: () async {
                              final insuranceProvider =
                                  Provider.of<InsuranceProvider>(context,
                                      listen: false);
                              final temporaryPdfFile =
                                  await insuranceProvider.getTemporaryPdfFile();
                              final uniqueFilename = DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString(); // Generate a unique filename
                              final downloadURL =
                                  await insuranceProvider.uploadPdfToFirebase(
                                      temporaryPdfFile, uniqueFilename);

                              if (downloadURL != null) {
                                // Upload successful, handle the downloadURL
                                print(
                                    'PDF uploaded to Firebase Storage. Download URL: $downloadURL');
                                try {
                                  Provider.of<InsuranceProvider>(context,
                                          listen: false)
                                      .isLoading = true;

                                  // Check if the user has a card in the "card" collection
                                  final cardSnapshot = await _firestore
                                      .collection('card')
                                      .where('uid', isEqualTo: user!.uid)
                                      .get();

                                  if (cardSnapshot.docs.isNotEmpty) {
                                    // User has a card, simulate the payment process
                                    await Future.delayed(Duration(seconds: 2));

                                    bool isPaymentSuccessful = true;

                                    if (isPaymentSuccessful) {
                                      // Payment was successful
                                      // ...
                                      // Add the insurance data to Firestore
                                      final insuranceData = {
                                        'user name': user?.displayName ?? '',
                                        'email': user?.email ?? '',
                                        'userId': user!.uid,
                                        'company name':
                                            widget.fieldData['companyName'],
                                        'Insurance Type':
                                            widget.fieldData['insuranceType'],
                                        'start date':
                                            widget.fieldData['start date'],
                                        'downloadUrl': downloadURL,
                                        'expiration date':
                                            widget.fieldData['expiration date'],
                                        'insurance number': widget
                                            .fieldData['insurance number'],
                                      };
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('Insurances')
                                            .add(insuranceData);
                                        print(
                                            'Download URL added to Firestore successfully.');

                                        // Display a payment confirmation message
                                        Fluttertoast.showToast(
                                          msg: "Payment successful!",
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: Colors.green,
                                        );
                                      } catch (error) {
                                        print(
                                            'Failed to add download URL to Firestore: $error');
                                        // Display a payment failure message
                                        Fluttertoast.showToast(
                                          msg:
                                              "Payment failed. Please try again.",
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: Colors.red,
                                        );
                                      }
                                    } else {
                                      // Payment failed
                                      // Display a payment failure message
                                      Fluttertoast.showToast(
                                        msg:
                                            "Payment failed. Please try again.",
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                  } else {
                                    // User does not have a card, display a message to add a card
                                    Fluttertoast.showToast(
                                      msg:
                                          "Please add a card before making a payment.",
                                      toastLength: Toast.LENGTH_LONG,
                                      backgroundColor: Colors.yellow,
                                    );
                                  }
                                  Provider.of<InsuranceProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                } catch (error) {
                                  // Handle any errors that occur during the payment simulation
                                  print(
                                      'Error simulating payment process: $error');
                                  throw error;
                                }

                                await _showPaymentSuccessDialog(context);
                                // Navigate to the home screen
                                Navigator.pushNamed(
                                    context, HomeScreen.routeName);
                              }
                            },
                          ),
                    SizedBox(
                      height: size.height * 0.02,
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

  Future<void> _showPaymentSuccessDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your payment was successful.'),
                Text('Thank you for using our services!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to the home screen
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
          ],
        );
      },
    );
  }
}

class InsuDetails extends StatelessWidget {
  const InsuDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Home insurance, also known as homeowner\'s insurance or property insurance, is a type of coverage that protects homeowners from financial losses related to their home and personal property. It provides financial security in the event of damage to or loss of a home due to various perils. Here\'s what home insurance typically covers:'),
          Text(
              '1. Dwelling Coverage:\n\tDwelling coverage protects the structure of your home, including the walls, roof, floors, and foundation. It covers damages caused by perils such as fire, windstorm, lightning, hail, and vandalism. The coverage amount should be sufficient to rebuild your home in case of a total loss.'),
          Text(
              '2. Other Structures:\n\tThis covers structures on your property that are not attached to your home, such as a detached garage, shed, or fence. Like dwelling coverage, it protects against perils.'),
          Text(
              '3. Personal Property:\n\tPersonal property coverage protects your belongings, including furniture, appliances, clothing, and electronics, from covered perils. It may also cover personal items outside your home, such as those in a storage unit or with you while traveling.'),
          Text(
              '4. Liability Coverage:\n\tLiability coverage provides financial protection if someone is injured on your property, and you are found legally responsible for their injuries. It also covers property damage you or your family members may cause to others. This coverage can extend to legal expenses.'),
          Text(
              '5. Additional Living Expenses (ALE) or Loss of Use:\n\tIf your home becomes uninhabitable due to a covered peril, ALE coverage helps with temporary living expenses. This can include hotel bills, restaurant meals, and other costs until your home is repaired or rebuilt.'),
          Text(
              '6. Medical Payments to Others:\n\tThis coverage pays for medical expenses if someone is injured on your property, regardless of whether you are legally liable. It is meant to cover minor injuries and avoid lawsuits.'),
          Text(
              '7. Natural Disasters and Special Coverage:\n\tHome insurance typically covers common perils, but some events may require additional coverage. For example, earthquakes and floods are often not covered by standard policies and may require separate policies or endorsements.'),
          Text(
              '8. Personal Liability Umbrella Policy (Optional):\n\tHomeowners can opt for additional personal liability coverage through an umbrella policy. This provides extra protection beyond the limits of their standard home insurance policy.'),
          Text(
              '9. Scheduled Personal Property (Optional):\n\tIf you have high-value items like jewelry, fine art, or collectibles, you can add scheduled personal property coverage to ensure they are adequately protected.'),
          Text(
              'It\'s important to review and understand the details and limitations of your home insurance policy, including deductibles, coverage limits, and any exclusions. Policyholders should also keep an up-to-date inventory of their personal property and its value to facilitate claims processing.'),
        ],
      ),
    );
  }
}
