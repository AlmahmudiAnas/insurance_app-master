import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_claim_card.dart';
import 'package:insurance_app/Util/My_Widget/my_drawer.dart';
import 'package:insurance_app/View/Shimmer/shimmer.dart';

class MySubmissionsScreen extends StatefulWidget {
  const MySubmissionsScreen({super.key});
  static String routeName = 'My Submissions';

  @override
  State<MySubmissionsScreen> createState() => _MySubmissionsScreenState();
}

class _MySubmissionsScreenState extends State<MySubmissionsScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  var companyName, insuranceType, price, status, uid;
  String user = FirebaseAuth.instance.currentUser!.uid;

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
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('claimSubmissions')
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text('');

                        case ConnectionState.waiting:
                          return ListView.separated(
                            itemCount: 10,
                            itemBuilder: (context, index) => NewsCardSkelton(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                          );

                        case ConnectionState.active:
                          return snapshot.hasData
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    companyName = snapshot.data?.docs[index]
                                        ['company name'];
                                    insuranceType = snapshot.data?.docs[index]
                                        ['insurance type'];
                                    uid = snapshot.data?.docs[index]['uid'];
                                    price = snapshot.data?.docs[index]
                                        ['claimAmount'];
                                    status =
                                        snapshot.data?.docs[index]['status'];
                                    return user == uid
                                        ? Column(
                                            children: [
                                              MyClaimsCard(
                                                companyName:
                                                    companyName.toString(),
                                                insuranceType:
                                                    insuranceType.toString(),
                                                price: price,
                                                status: status,
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.02),
                                            ],
                                          )
                                        : Container();
                                  },
                                )
                              : Container(
                                  child: Center(
                                    child: Text(
                                      'No Data',
                                      style: GoogleFonts.anekLatin(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );

                        default:
                          {
                            return Center(
                              child: Text(
                                'Make new report',
                                style: GoogleFonts.anekLatin(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                      }
                    },
                  ),
                ),
                // child: Column(
                //   children: [
                //     //MyClaimsCard(),
                //     SizedBox(height: size.height * 0.02),
                //   ],
                // ),
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
