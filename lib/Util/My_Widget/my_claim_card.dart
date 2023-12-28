import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyClaimsCard extends StatefulWidget {
  const MyClaimsCard({
    super.key,
    required this.companyName,
    required this.insuranceType,
    required this.price,
    required this.status,
  });

  final String companyName, insuranceType, price, status;

  @override
  State<MyClaimsCard> createState() => _MyClaimsCardState();
}

class _MyClaimsCardState extends State<MyClaimsCard> {
  Color statusColor() {
    if (widget.status == "Come to company") {
      return Colors.green;
    } else if (widget.status == "Rejected") {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.13,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (widget.companyName == 'Company 1')
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage:
                  AssetImage('images/2012177_logo_1531721978_n.png'),
            ),
          if (widget.companyName == 'Company 2')
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/Al Baraka.png'),
            ),
          if (widget.companyName == 'Alwatheka')
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/ALWATHEKA.png'),
            ),
          if (widget.companyName == 'Qafela')
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/qafela_insurance.png'),
            ),
          SizedBox(width: size.width * 0.05),
          Container(
            width: size.width * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: size.width * 0.5,
                  child: Text(
                    widget.insuranceType,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.anekLatin(fontSize: size.width * 0.05),
                  ),
                ),
                SizedBox(height: size.width * 0.01),
                Text(
                  widget.companyName,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.anekLatin(
                    fontSize: size.width * 0.05,
                  ),
                ),
                SizedBox(height: size.width * 0.01),
                Text(
                  '${widget.price}\$',
                  style: GoogleFonts.anekLatin(
                    fontSize: size.width * 0.05,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: size.width * 0.02),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.status,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: size.width * 0.03),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: statusColor(),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
