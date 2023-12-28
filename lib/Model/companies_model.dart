// // class Companies {
// //   final String companyName, imageURL;
// //   final List<InsuranceType> insuranceType;
// //   Companies({
// //     required this.companyName,
// //     required this.imageURL,
// //     required this.insuranceType,
// //   });
// // }

// // class InsuranceType {
// //   final String name;
// //   double price;
// //   InsuranceType({
// //     required this.name,
// //     required this.price,
// //   });
// // }

// List<Companies> companiesList = [
//   Companies(
//     companyName: 'Al Namaa',
//     imageURL: 'images/2012177_logo_1531721978_n.png',
//     insuranceType: [
//       InsuranceType(name: 'Health Insurance', price: 40),
//       InsuranceType(name: 'Car Insurance', price: 100),
//       InsuranceType(name: 'Life Insurance', price: 200),
//       InsuranceType(name: 'Home Insurance', price: 250),
//     ],
//   ),
//   Companies(
//     companyName: 'Al Baraka',
//     imageURL: 'images/Al Baraka.png',
//     insuranceType: [
//       InsuranceType(name: 'Health Insurance', price: 40),
//       InsuranceType(name: 'Travel Insurance', price: 150),
//       InsuranceType(name: 'Property Insurance', price: 100),
//       InsuranceType(name: 'Home Insurance', price: 250),
//     ],
//   ),
//   Companies(
//     companyName: 'ALWATHEKA',
//     imageURL: 'images/ALWATHEKA.png',
//     insuranceType: [
//       InsuranceType(name: 'Propery Insurance', price: 140),
//       InsuranceType(name: 'General insurance', price: 500),
//       InsuranceType(name: 'Flood Insurance', price: 600),
//       InsuranceType(name: 'Life Insurance', price: 1000),
//     ],
//   ),
//   Companies(
//     companyName: 'Watanya',
//     imageURL: 'images/watanya.png',
//     insuranceType: [
//       InsuranceType(name: 'Business interruption Insurance', price: 1000),
//       InsuranceType(name: 'Income protection Insurance', price: 740),
//       InsuranceType(name: 'Life Insurance', price: 900),
//     ],
//   ),
// ];

// class InsuranceType {
//   final String name;
//   double price;
//   InsuranceType({
//     required this.name,
//     required this.price,
//   });
// }

// class Companies {
//   final String companyName, imageURL;
//   final List<InsuranceType> insuranceType;
//   Companies({
//     required this.companyName,
//     required this.imageURL,
//     required this.insuranceType,
//   });
// }

// class InsuranceData {
//   final InsuranceType insuranceType;
//   final List<Companies> companies;
//   InsuranceData({
//     required this.insuranceType,
//     required this.companies,
//   });
// }

// List<InsuranceType> insuranceTypes = [
//   InsuranceType(name: 'Health Insurance', price: 40),
//   InsuranceType(name: 'Car Insurance', price: 100),
//   InsuranceType(name: 'Life Insurance', price: 200),
//   InsuranceType(name: 'Property Insurance', price: 250),
//   InsuranceType(name: 'Travel Insurance', price: 150),
//   InsuranceType(name: 'Flood Insurance', price: 600),
//   InsuranceType(name: 'Business interruption Insurance', price: 1000),
//   InsuranceType(name: 'Income protection Insurance', price: 740),
// ];

// // List<Companies> companiesList = [
// //   Companies(
// //     companyName: 'Al Namaa',
// //     imageURL: 'images/2012177_logo_1531721978_n.png',
// //     insuranceType: [
// //       'Health Insurance',
// //       'Car Insurance',
// //       'Life Insurance',
// //       'Property Insurance'
// //     ],
// //   ),
// //   Companies(
// //     companyName: 'Al Baraka',
// //     imageURL: 'images/Al Baraka.png',
// //     insuranceType: [
// //       'Health Insurance',
// //       'Travel Insurance',
// //       'Property Insurance'
// //     ],
// //   ),
// //   Companies(
// //     companyName: 'ALWATHEKA',
// //     imageURL: 'images/ALWATHEKA.png',
// //     insuranceType: ['Property Insurance', 'Flood Insurance', 'Life Insurance'],
// //   ),
// //   Companies(
// //     companyName: 'Watanya',
// //     imageURL: 'images/watanya.png',
// //     insuranceType: [
// //       'Business interruption Insurance',
// //       'Income protection Insurance',
// //       'Life Insurance'
// //     ],
// //   ),
// // ];

// List<InsuranceData> insuranceDataList = insuranceTypes.map((insuranceType) {
//   List<Companies> companiesForType = companiesList.where((company) {
//     return company.insuranceType.contains(insuranceType.name);
//   }).toList();

//   return InsuranceData(
//       insuranceType: insuranceType, companies: companiesForType);
// }).toList();

class InsuranceType {
  String name;
  List<Company> companies;

  InsuranceType({
    required this.name,
    required this.companies,
  });
}

class Company {
  String companyName;
  String imageURL;
  double price;

  Company({
    required this.companyName,
    required this.imageURL,
    required this.price,
  });
}
