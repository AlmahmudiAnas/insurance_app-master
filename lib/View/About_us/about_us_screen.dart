import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});
  static String routeName = 'About Us Screen';

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 167, 201, 87),
        title: Text(
          'About Us',
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
      body: SafeArea(
        child: Stack(
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
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 80),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                width: size.width / 1.15,
                height: size.height / 1.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'About Tameen',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'Welcome to Tameen, your trusted partner in insurance solutions. We are committed to providing you with peace of mind and financial security through our comprehensive range of insurance services. Here\'s what sets us apart:'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Our Mission',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'At Tameen, our mission is simple yet profound: to protect what matters most to you. Whether it\'s safeguarding your health, securing your business, or ensuring your loved ones\' future, we are here to help you navigate life\'s uncertainties.'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Your Security, Our Priority',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'Your security is our top priority. We work tirelessly to understand your unique needs and offer insurance solutions tailored to you. With us, you\'re not just a policyholder; you\'re a valued member of the Tameen family.'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Our Services',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'Health Insurance: We offer comprehensive health insurance plans to keep you and your family covered when it matters most. Your well-being is our concern.'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'Business Insurance: Protect your business with our range of commercial insurance options. From small startups to established enterprises, we have you covered.'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'Auto Insurance: Safeguard your vehicles and travel with confidence. Our auto insurance plans are designed to provide you with peace of mind on the road.'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'Property Insurance: Whether it\'s your home or commercial property, our property insurance ensures that your investments are safe and secure.'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'Life Insurance: Plan for the future and protect your loved ones with our life insurance policies. It\'s a gift of financial security for generations to come.'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Why Choose Tameen?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'Expertise: Our team of insurance professionals brings years of industry expertise to the table. We understand the intricacies of insurance, so you don\'t have to.'),
                      Text(
                          'Customer-Centric: Your needs are at the heart of everything we do. We are dedicated to providing exceptional customer service and support.'),
                      Text(
                          'Innovation: We stay ahead of the curve by embracing technology and innovation. This allows us to offer you convenient, efficient, and modern insurance solutions.'),
                      Text(
                          'Trust: Tameen is synonymous with trust. We have earned the confidence of countless individuals and businesses by consistently delivering on our promises.'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                          'We are here to answer your questions, address your concerns, and guide you through your insurance journey. Feel free to reach out to our friendly customer support team at info@tameen.ly or 092XXXXXXXXX and 091XXXXXXXXX.\nThank you for choosing Tameen as your insurance partner. Together, we\'ll build a secure future for you and your loved ones.\nYour Security, Our Commitment.')
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
}
