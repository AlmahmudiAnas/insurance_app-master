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

class carPdfScreen extends StatefulWidget {
  const carPdfScreen({
    Key? key,
    required this.fieldData,
  }) : super(key: key);

  final Map<String, dynamic> fieldData;

  @override
  State<carPdfScreen> createState() => _carPdfScreenState();
}

class _carPdfScreenState extends State<carPdfScreen> {
  String? pdfPath;

  @override
  void initState() {
    super.initState();
    generatePdf();
  }

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
                      ['Car Model', widget.fieldData['carType'].toString()],
                      ['Owner Name', widget.fieldData['carOwner'].toString()],
                      ['Address', widget.fieldData['address'].toString()],
                      [
                        'Chassis Number',
                        widget.fieldData['chassisNumber'].toString()
                      ],
                      [
                        'Plate Number',
                        widget.fieldData['plateNumber'].toString()
                      ],
                      [
                        'Engine Power',
                        widget.fieldData['enginePower'].toString()
                      ],
                      [
                        'Motor Number',
                        widget.fieldData['motorNumber'].toString()
                      ],
                      ['Used For', widget.fieldData['usedFor'].toString()],
                      [
                        'Year Car Made',
                        widget.fieldData['yearMade'].toString()
                      ],
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

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
                                        await _showPaymentSuccessDialog(
                                            context);
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
              'Car insurance is a type of coverage that provides financial protection for vehicle owners in the event of accidents, theft, damage to the vehicle, and other related incidents. It is typically required by law in many countries and states to operate a motor vehicle on public roads. Car insurance policies can vary widely, but they often include the following types of coverage:'),
          Text(
              '1. Liability Insurance:\n\tBodily Injury Liability: Covers medical expenses, legal fees, and damages if you injure someone else in a car accident.\Property Damage Liability: Pays for damage you cause to another person\'s property, such as their vehicle or a building.'),
          Text(
              '2. Collision Coverage:\n\tCovers repair or replacement costs for your vehicle if it\'s damaged in a collision with another vehicle or object, regardless of fault.'),
          Text(
              '3. Comprehensive Coverage:\n\tProtects your vehicle from non-collision-related damage, such as theft, vandalism, fire, natural disasters, or hitting an animal.'),
          Text(
              '4. Uninsured and Underinsured Motorist Coverage:\n\tProvides coverage if you\'re in an accident caused by a driver who doesn\'t have insurance (uninsured) or doesn\'t have enough insurance (underinsured) to cover your damages.'),
          Text(
              '5. Personal Injury Protection (PIP) or Medical Payments Coverage:\n\tPays for medical expenses for you and your passengers, regardless of fault, in case of injury sustained in a car accident.'),
          Text(
              '6. Gap Insurance:\n\tCovers the "gap" between what you owe on your car loan or lease and the actual cash value of your vehicle if it\'s totaled in an accident.'),
          Text(
              '7. Rental Reimbursement Coverage:\n\tPays for a rental car if your vehicle is being repaired due to a covered claim.'),
          Text(
              '8. Towing and Labor Coverage:\n\tCovers the cost of towing your vehicle and labor costs for on-site repairs (e.g., changing a flat tire).'),
          Text(
              '9. Custom Parts and Equipment Coverage:\n\tProvides coverage for customized or aftermarket additions to your vehicle, such as stereo systems or rims.'),
          Text(
              '10. Roadside Assistance:\n\tOffers services like jump-starting a dead battery, delivering fuel, or unlocking your car if you\'re locked out.'),
          Text(
              '11. Classic Car Insurance:\n\tDesigned for vintage or collectible cars and provides agreed-upon value coverage.'),
          Text(
              '12. Usage-Based or Pay-As-You-Go Insurance:\n\tPremiums are based on your driving habits and mileage.'),
          Text(
              '13. Non-Owner Car Insurance:\n\tProvides liability coverage if you don\'t own a vehicle but occasionally drive one, such as a rental car.'),
          Text(
              '14. SR-22 Insurance:\n\tA certificate of financial responsibility for high-risk drivers required by some states after certain violations.'),
          Text(
              '15. Teen Driver Insurance:\n\tSpecial policies designed for young, inexperienced drivers, often with higher premiums.'),
        ],
      ),
    );
  }
}
