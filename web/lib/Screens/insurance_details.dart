import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class InsuranceDetailsDB extends StatelessWidget {
  const InsuranceDetailsDB({
    super.key,
    required this.pdfUrl,
    required this.insuranceType,
    required this.companyName,
    required this.insuranceNumber,
    required this.date,
    required this.email,
    required this.username,
  });
  final String pdfUrl,
      companyName,
      insuranceType,
      insuranceNumber,
      date,
      email,
      username;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Insurance Details'),
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
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SizedBox(
                    height: size.height * 0.6,
                    child: HtmlWidget(
                      '<iframe src="$pdfUrl" width="100%" height="100%"></iframe>',
                    ),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.01),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                width: size.width * 0.4,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Company Name:'),
                          SizedBox(width: size.width * 0.01),
                          Text(companyName),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Text('Insurance Type:'),
                          SizedBox(width: size.width * 0.01),
                          Text(insuranceType),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Text('Insurance Number:'),
                          SizedBox(width: size.width * 0.01),
                          Text(insuranceNumber),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Divider(),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Text('Name:'),
                          SizedBox(width: size.width * 0.01),
                          Text(username),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Text('Email:'),
                          SizedBox(width: size.width * 0.01),
                          Text(email),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Text('Passport Number:'),
                          SizedBox(width: size.width * 0.01),
                          Text('ack456'),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Text('Phone Number:'),
                          SizedBox(width: size.width * 0.01),
                          Text('0920000000'),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Text('Starting Date:'),
                          SizedBox(width: size.width * 0.01),
                          Text(date),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
