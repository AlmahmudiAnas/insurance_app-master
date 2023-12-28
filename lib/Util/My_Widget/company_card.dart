import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({
    super.key,
    required this.size,
    required this.companyTitle,
    required this.imageURL,
    required this.onPressed,
  });

  final Size size;
  final String companyTitle, imageURL;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        margin: EdgeInsets.only(right: 10),
        width: size.width * 0.4,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5), //to change position of shadow
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.1,
                child: Image.asset(
                  imageURL,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                companyTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.actor(
                  fontSize: size.width / 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
