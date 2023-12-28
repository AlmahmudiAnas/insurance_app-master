import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/View/Shimmer/shimmer.dart';
import '../Widgets/d_insurance_card.dart';
import 'insurance_details.dart';

class TravelInsuranceDB extends StatefulWidget {
  const TravelInsuranceDB({super.key});

  @override
  State<TravelInsuranceDB> createState() => _TravelInsuranceDBState();
}

class _TravelInsuranceDBState extends State<TravelInsuranceDB> {
  var companyName,
      insuranceType,
      downloadUrl,
      insuranceNumber,
      date,
      username,
      email;

  // Method to get the current user's ID
  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Companies')
                  .doc(
                      getCurrentUserId()) // Use the current user's ID as the document ID
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.separated(
                    itemBuilder: (context, index) => NewsCardSkelton(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: 8,
                  );
                } else if (snapshot.hasData) {
                  // Access the data from the document snapshot
                  var userCompany = snapshot.data?['company name'];

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Insurances')
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text('');
                        case ConnectionState.waiting:
                          return ListView.separated(
                            itemBuilder: (context, index) => NewsCardSkelton(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemCount: 8,
                          );

                        case ConnectionState.active:
                          return snapshot.hasData
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    companyName = snapshot.data?.docs[index]
                                        ['company name'];
                                    date = snapshot.data?.docs[index]
                                        ['start date'];
                                    insuranceType = snapshot.data?.docs[index]
                                        ['Insurance Type'];
                                    downloadUrl = snapshot.data?.docs[index]
                                        ['downloadUrl'];
                                    insuranceNumber = snapshot.data?.docs[index]
                                        ['insurance number'];
                                    username =
                                        snapshot.data?.docs[index]['user name'];
                                    email = snapshot.data?.docs[index]['email'];
                                    final document = snapshot.data?.docs[index];
                                    final documentId = document?.id;
                                    if (companyName == userCompany &&
                                        insuranceType == 'Travel Insurance') {
                                      // Display the insurance data for the user's company
                                      return Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () async {
                                              // Retrieve the downloadUrl of the specific insurance document
                                              String pdfUrl = snapshot.data
                                                  ?.docs[index]['downloadUrl'];

                                              // Navigate to the InsuranceDetailsDB screen with the correct pdfUrl
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      InsuranceDetailsDB(
                                                    pdfUrl:
                                                        pdfUrl, // Pass the correct pdfUrl
                                                    insuranceType:
                                                        insuranceType,
                                                    companyName: companyName,
                                                    insuranceNumber:
                                                        insuranceNumber,
                                                    date: date,
                                                    email: email,
                                                    username: username,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: IgnorePointer(
                                              child: DBInsuranceCard(
                                                size: size,
                                                companyName: companyName,
                                                insuranceType: insuranceType,
                                                date: date,
                                                insuranceNumber:
                                                    insuranceNumber,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
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
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                      }
                      ;
                    },
                  );
                } else {
                  // Handle case when there's an error or no data
                  return Container(
                    child: Center(
                      child: Text('Error retrieving data'),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
