import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_drawer.dart';
import 'package:insurance_app/View/Login_Screen/login_screen.dart';
import 'package:insurance_app/View/PaymentScreen/payment_screen.dart';
import 'package:insurance_app/View_Model/auth_provider.dart';
import 'package:insurance_app/View_Model/payment_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static String routeName = 'Profile Screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  var nameOnCard, cardNumber, cvcNumber, expireDate;

  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference userCard = FirebaseFirestore.instance.collection('card');

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
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 70.h,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: FutureBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                future: userCollection.doc(user!.uid).get()
                                    as Future<
                                        DocumentSnapshot<
                                            Map<String, dynamic>>>?,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.error),
                                    );
                                  }
                                  final userData = snapshot.data?.data();
                                  final imageUrl =
                                      userData?['imageUrl'] as String?;
                                  if (imageUrl != null) {
                                    return CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(imageUrl),
                                    );
                                  } else {
                                    return CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.person),
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 20.w),
                            FutureBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              future: userCollection.doc(user!.uid).get()
                                  as Future<
                                      DocumentSnapshot<Map<String, dynamic>>>?,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                final userData = snapshot.data?.data();
                                final displayName =
                                    userData?['full name'] as String?;
                                final email = userData?['email'] as String?;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Hi, $displayName',
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    Text(
                                      email ?? '',
                                      style: GoogleFonts.roboto(
                                        color: Colors.grey.shade400,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      //card
                      Container(
                        width: size.width * 0.7,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 86, 11, 173),
                              Color.fromARGB(255, 67, 97, 238),
                            ],
                            stops: [0.1, 0.9],
                          ),
                        ),
                        child: FutureBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          future: Provider.of<PaymentProvider>(context,
                                  listen: false)
                              .getCardData(user!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Show a loading indicator while fetching the data
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              // Handle any errors that occur during the data retrieval
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              // Extract the card data from the snapshot
                              final cardData = snapshot.data!.data();
                              print('Snapshot: $snapshot');
                              print('Card Data: $cardData');

                              if (cardData != null) {
                                // Compare the uid field with the user's uid
                                print('Snapshot: $snapshot');
                                print('Card Data: $cardData');

                                final cardUid = cardData['uid'];
                                if (cardUid == user!.uid) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cardData['cardNumber'] ?? 'No Data',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            cardData['nameOnCard'] ?? 'No Data',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 7),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Expiry Date',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    cardData['expireDate'] ??
                                                        'No Data',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'CVV',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    cardData['cvcNumber'] ??
                                                        'No Data',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.h),
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<PaymentProvider>()
                                                  .deleteDocumentFromFirebase();
                                            },
                                            child: Text(
                                              'Remove Card',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  // Card does not belong to the user
                                  return Text('Card not found');
                                }
                              } else {
                                // Card data is null
                                return Text('No card data found');
                              }
                            } else {
                              // Handle the case where no data is available
                              return Text('No card data found');
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        'Account',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w900,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, PaymentScreen.routeName);
                        },
                        leading: Icon(
                          FontAwesomeIcons.firstOrder,
                          color: Colors.grey.shade400,
                          size: 30,
                        ),
                        title: Text(
                          'Payment',
                          style: GoogleFonts.roboto(
                            fontSize: 19.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Divider(
                        thickness: 2,
                        height: 2,
                      ),

                      SizedBox(height: 10.h),
                      ListTile(
                        onTap: () {
                          context.read<LoginProvider>().logout();
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        leading: Icon(
                          Icons.logout_outlined,
                          color: Colors.grey.shade400,
                        ),
                        title: Text(
                          'Logout',
                          style: GoogleFonts.roboto(fontSize: 19.sp),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
