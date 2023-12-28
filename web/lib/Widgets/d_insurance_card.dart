import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DBInsuranceCard extends StatelessWidget {
  const DBInsuranceCard({
    super.key,
    required this.size,
    required this.companyName,
    required this.insuranceType,
    required this.date,
    required this.insuranceNumber,
  });

  final Size size;
  final String companyName, insuranceType, date, insuranceNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.64,
      height: size.height * 0.18,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          children: [
            if (companyName == 'Company 1')
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage:
                    AssetImage('images/2012177_logo_1531721978_n.png'),
              ),
            if (companyName == 'Company 2')
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/Al Baraka.png'),
              ),
            if (companyName == 'Alwatheka')
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/ALWATHEKA.png'),
              ),
            if (companyName == 'Qafela')
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/qafela_insurance.png'),
              ),
            SizedBox(width: size.width * 0.06),
            Container(
              width: size.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      insuranceType,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.anekLatin(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.005),
                  Text(
                    companyName,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.width * 0.005),
                  Text(date),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.01),
            Text(
              insuranceNumber,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
