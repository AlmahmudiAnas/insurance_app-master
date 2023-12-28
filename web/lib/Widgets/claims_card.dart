import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider.dart';

class ClaimInsuranceCard extends StatelessWidget {
  final String address;
  final String claimAmount;
  final String companyName;
  final String fullName;
  final String imageURL;
  final String incidentDetails;
  final String insuranceType;
  final String location;
  final String phone;
  final String policyNumber;
  final String status;
  final String docID;

  ClaimInsuranceCard({
    required this.address,
    required this.claimAmount,
    required this.companyName,
    required this.fullName,
    required this.imageURL,
    required this.incidentDetails,
    required this.insuranceType,
    required this.location,
    required this.phone,
    required this.policyNumber,
    required this.status,
    required this.docID,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.64,
      height: size.height * 0.5,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Claim Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Address: $address'),
                  Text('Claim Amount: $claimAmount'),
                  Text('Company Name: $companyName'),
                  Text('Full Name: $fullName'),
                  Text('Incident Details: $incidentDetails'),
                  Text('Insurance Type: $insuranceType'),
                  Text('Location: $location'),
                  Text('Phone: $phone'),
                  Text('Policy Number: $policyNumber'),
                  Text('Status: $status'),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey, // Customize the color of the divider here
            thickness: 1, // Customize the thickness of the divider here
            indent: 16, // Customize the space before the divider here
            endIndent: 16, // Customize the space after the divider here
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.3,
                height: size.height * 0.35,
                padding: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Image.network(
                  imageURL,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the "Decline" button here
                      Provider.of<DashboardProvider>(context, listen: false)
                          .claimStatusUpdate('Rejected', docID);
                    },
                    child: Text('Decline'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the "Approve" button here
                      Provider.of<DashboardProvider>(context, listen: false)
                          .claimStatusUpdate('Come to company', docID);
                    },
                    child: Text('Approve'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
