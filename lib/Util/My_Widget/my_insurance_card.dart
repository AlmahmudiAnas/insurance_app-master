import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:provider/provider.dart';

class MyInsuranceCard extends StatelessWidget {
  MyInsuranceCard({
    super.key,
    required this.size,
    required this.insuranceType,
    required this.companyName,
    required this.date,
    required this.pdfUrl,
    this.docId,
  });

  final Size size;
  final String insuranceType, companyName, date;
  final String pdfUrl;
  final docId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.1,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              flex: 1,
              onPressed: (value) {
                context
                    .read<InsuranceProvider>()
                    .deleteDocumentFromFirebase(pdfUrl, docId);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
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
              width: size.width * 0.47,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 0.5,
                    child: Text(
                      insuranceType,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.anekLatin(fontSize: size.width * 0.04),
                    ),
                  ),
                  SizedBox(height: size.width * 0.01),
                  Text(
                    companyName,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.width * 0.01),
                  Text(date),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Icon(
              Icons.arrow_forward_ios,
              size: size.width * 0.07,
            ),
          ],
        ),
      ),
    );
  }
}
