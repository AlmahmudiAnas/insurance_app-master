import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_drawer.dart';
import 'package:insurance_app/Util/My_Widget/my_insurance_card.dart';
import 'package:insurance_app/View/My_Pdf_View/pdf_screen.dart';
import 'package:insurance_app/View/New_Insurance/new_Insurance.dart';
import 'package:insurance_app/View/Shimmer/shimmer.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = 'HomeScreen V2';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  var companyName, date, insuranceType, downloadUrl, userId;
  String user = FirebaseAuth.instance.currentUser!.uid;

  Future<String> downloadPdf(String url) async {
    final response = await http.get(Uri.parse(url));

    final appDocDir = await getApplicationDocumentsDirectory();
    final directoryPath = appDocDir.path;
    final filePath =
        '$directoryPath/example.pdf'; // Replace with the desired file name

    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<InsuranceProvider>(context, listen: false)
        .checkExpirationDates();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          backgroundColor: Color.fromARGB(255, 167, 201, 87),
          elevation: 0,
          title: Center(
            child: Text(
              'Home Page',
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 15, right: 15, bottom: 0),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height,
                    child: Column(
                      children: [
                        Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(80),
                          child: Container(
                            width: size.width,
                            height: size.height * 0.32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: size.width * 0.04,
                                  top: size.height * 0.03,
                                  child: Text(
                                    'Welcome to Insurance',
                                    style: GoogleFonts.alfaSlabOne(
                                      fontSize: size.width * 0.06,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: size.width * 0.04,
                                  top: size.height * 0.07,
                                  child: Text(
                                    'The best app to keep all your insurances',
                                    style: GoogleFonts.acme(
                                      fontSize: size.width * 0.05,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: size.height * 0,
                                  right: 0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                    child: Image.asset(
                                      'images/life360-safehome.png',
                                      scale: 2.5,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height * 0.5,
                          margin: EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'My insurance',
                                    style: GoogleFonts.alegreya(
                                        fontSize: size.width * 0.05),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, NewInsurance.routeName);
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width,
                                height: size.height * 0.44,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Insurances')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                        return Text('');

                                      case ConnectionState.waiting:
                                        return ListView.separated(
                                          itemBuilder: (context, index) =>
                                              NewsCardSkelton(),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 16),
                                          itemCount: 6,
                                        );

                                      case ConnectionState.active:
                                        return snapshot.hasData
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data?.docs.length,
                                                itemBuilder: (context, index) {
                                                  companyName =
                                                      snapshot.data?.docs[index]
                                                          ['company name'];
                                                  date =
                                                      snapshot.data?.docs[index]
                                                          ['start date'];
                                                  insuranceType =
                                                      snapshot.data?.docs[index]
                                                          ['Insurance Type'];
                                                  downloadUrl =
                                                      snapshot.data?.docs[index]
                                                          ['downloadUrl'];
                                                  userId = snapshot.data
                                                      ?.docs[index]['userId'];
                                                  final document = snapshot
                                                      .data?.docs[index];
                                                  final documentId =
                                                      document?.id;
                                                  return user == userId
                                                      ? InkWell(
                                                          onTap: () {
                                                            // Retrieve the downloadUrl of the specific insurance document
                                                            String pdfUrl = snapshot
                                                                    .data
                                                                    ?.docs[index]
                                                                ['downloadUrl'];
                                                            print(
                                                                'this is download link ====> $downloadUrl');
                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //     builder: (context) => PdfScreen(
                                                            //         downloadUrl:
                                                            //             snapshot
                                                            //                 .data
                                                            //                 ?.docs[index]['downloadUrl']),
                                                            //   ),
                                                            // );
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PdfScreen(
                                                                  pdfUrl:
                                                                      pdfUrl,
                                                                  insuranceType:
                                                                      insuranceType,
                                                                  docId:
                                                                      documentId,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child:
                                                              MyInsuranceCard(
                                                            companyName:
                                                                companyName,
                                                            date: date,
                                                            insuranceType:
                                                                insuranceType,
                                                            size: size,
                                                            pdfUrl: downloadUrl,
                                                            docId: documentId,
                                                          ),
                                                        )
                                                      : Container();
                                                },
                                              )
                                            : Container(
                                                child: Center(
                                                  child: Text('No Insurances'),
                                                ),
                                              );
                                      default:
                                        {
                                          return Center(
                                            child: Text(
                                              'Make new Insurance',
                                              style: GoogleFonts.acme(
                                                fontSize: 15,
                                              ),
                                            ),
                                          );
                                        }
                                    }
                                  },
                                ),
                                // child: ListView.builder(
                                //   itemCount: myInsuranceList.length,
                                //   itemBuilder: (context, index) {
                                //     MyInsurance myInsurance =
                                //         myInsuranceList[index];
                                //     return MyInsuranceCard(
                                //       size: size,
                                //       imageURL: myInsurance.imageURL,
                                //       insuranceType: myInsurance.insuranceType,
                                //       companyName: myInsurance.companyName,
                                //       date: myInsurance.date,
                                //     );
                                //   },
                                // ),
                              ),
                            ],
                          ),
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

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
