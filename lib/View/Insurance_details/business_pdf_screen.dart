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

class BusinessPdfScreen extends StatefulWidget {
  const BusinessPdfScreen({
    super.key,
    required this.fieldData,
  });
  final Map<String, dynamic> fieldData;

  @override
  State<BusinessPdfScreen> createState() => _BusinessPdfScreenState();
}

class _BusinessPdfScreenState extends State<BusinessPdfScreen> {
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
                        'Business Name',
                        widget.fieldData['business name'].toString()
                      ],
                      [
                        'Business Address',
                        widget.fieldData['business address'].toString()
                      ],
                      [
                        'Business Nature',
                        widget.fieldData['business nature'].toString()
                      ],
                      [
                        'Business Sectore',
                        widget.fieldData['business sectore'].toString()
                      ],
                      [
                        'Number of Employees',
                        widget.fieldData['number of employees'].toString()
                      ],
                      [
                        'Annual Revenue',
                        widget.fieldData['annual revenue'].toString()
                      ],
                      [
                        'Risk Management',
                        widget.fieldData['risk management'].toString()
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
              'Business insurance, also known as commercial insurance, is a type of coverage designed to protect businesses from financial losses due to various risks and liabilities. Business insurance policies can be tailored to meet the specific needs of different types of businesses. Here are some common types of business insurance:'),
          Text(
              '1. General Liability Insurance:\n\tProtects businesses from third-party claims of bodily injury, property damage, or personal injury. It covers legal fees, medical expenses, and settlements or judgments.\nCommonly required for business leases and contracts.'),
          Text(
              '2. Commercial Property Insurance:\n\tCovers physical assets such as buildings, equipment, inventory, and furnishings against damage or loss due to events like fire, vandalism, theft, or natural disasters.\nBusiness interruption insurance, a component of property insurance, can compensate for lost income if the business is temporarily unable to operate.'),
          Text(
              '3. Professional Liability Insurance (Errors and Omissions Insurance):\n\tEssential for service-based businesses and professionals (e.g., doctors, lawyers, consultants) to protect against claims of negligence, errors, or omissions in services provided.\nHelps cover legal defense costs and settlements.'),
          Text(
              '4. Workers\' Compensation Insurance:\n\tRequired in most states for businesses with employees.\nProvides medical benefits and wage replacement to employees who suffer work-related injuries or illnesses.\nHelps protect businesses from employee lawsuits related to workplace injuries.'),
          Text(
              '5. Product Liability Insurance:\n\tRelevant for businesses that manufacture, distribute, or sell products.\nCovers legal costs and damages if a product causes harm or injury to consumers.'),
          Text(
              '6. Commercial Auto Insurance:\n\tNecessary for businesses that own and use vehicles for business purposes.\nProvides coverage for accidents, property damage, and liability related to business-owned vehicles.'),
          Text(
              '7. Cyber Liability Insurance:\n\tProtects against data breaches, cyberattacks, and the theft of sensitive customer information.\nCovers costs associated with data recovery, notification, legal defense, and regulatory fines.'),
          Text(
              '8. Directors and Officers (D&O) Insurance:\n\tOffers protection to directors and officers of a company from personal liability in cases of alleged wrongful acts, mismanagement, or financial decisions.\nOften used in corporations and nonprofits.'),
          Text(
              '9. Business Owner\'s Policy (BOP):\n\tA bundled insurance package that typically includes general liability, property, and business interruption coverage.\nDesigned for small to mid-sized businesses to save on insurance costs.'),
          Text(
              '10. Employment Practices Liability Insurance (EPLI):\n\tProtects against claims of discrimination, harassment, wrongful termination, and other employment-related issues.\nImportant for businesses with employees.'),
          Text(
              '11. Commercial Umbrella Insurance:\n\tProvides additional liability coverage beyond the limits of other liability policies.\Useful for businesses that want extra protection against catastrophic claims.'),
          Text(
              '12. Key Person Insurance:\n\tCovers the financial loss a business may suffer due to the death or disability of a key employee or owner.\nHelps the business recover and find a replacement.'),
        ],
      ),
    );
  }
}
