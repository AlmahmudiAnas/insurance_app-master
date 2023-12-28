import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/View/Shimmer/shimmer.dart';

import '../Widgets/claims_card.dart';

class ClaimSubmissionsDB extends StatefulWidget {
  const ClaimSubmissionsDB({super.key});
  static String routeName = 'Claim Submissions Dashboard';

  @override
  State<ClaimSubmissionsDB> createState() => _ClaimSubmissionsDBState();
}

class _ClaimSubmissionsDBState extends State<ClaimSubmissionsDB> {
  var address,
      claimAmount,
      companyName,
      fullName,
      imageURL,
      incidentDetails,
      insuranceType,
      location,
      phone,
      policyNumber,
      status,
      docID;

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
        child: StreamBuilder<DocumentSnapshot>(
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
                var userCompany = snapshot.data?['company name'];
                print(userCompany);
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('claimSubmissions')
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
                          itemCount: 6,
                        );

                      case ConnectionState.active:
                        return snapshot.hasData
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  address =
                                      snapshot.data?.docs[index]['address'];
                                  claimAmount =
                                      snapshot.data?.docs[index]['claimAmount'];
                                  companyName = snapshot.data?.docs[index]
                                      ['company name'];
                                  fullName =
                                      snapshot.data?.docs[index]['full name'];
                                  imageURL =
                                      snapshot.data?.docs[index]['imageURL'];
                                  incidentDetails = snapshot.data?.docs[index]
                                      ['incidentDetails'];
                                  insuranceType = snapshot.data?.docs[index]
                                      ['insurance type'];
                                  location =
                                      snapshot.data?.docs[index]['location'];
                                  phone = snapshot.data?.docs[index]['phone'];
                                  policyNumber = snapshot.data?.docs[index]
                                      ['policyNumber'];
                                  status = snapshot.data?.docs[index]['status'];
                                  docID =
                                      snapshot.data?.docs[index].id.toString();
                                  print(companyName);
                                  if (companyName == userCompany &&
                                      status == 'Pending') {
                                    return ClaimInsuranceCard(
                                      address: address,
                                      claimAmount: claimAmount,
                                      companyName: companyName,
                                      fullName: fullName,
                                      imageURL: imageURL,
                                      incidentDetails: incidentDetails,
                                      insuranceType: insuranceType,
                                      location: location,
                                      phone: phone,
                                      policyNumber: policyNumber,
                                      status: status,
                                      docID: docID,
                                    );
                                  }
                                },
                              )
                            : Container(
                                child: Center(
                                  child: Text('No Claims'),
                                ),
                              );
                      default:
                        {
                          return Center(
                            child: Text('No New Claims'),
                          );
                        }
                    }
                  },
                );
              } else {
                return Container(
                  child: Center(
                    child: Text('Error retrieving data'),
                  ),
                );
              }
            }),
      ),
    );
  }
}
