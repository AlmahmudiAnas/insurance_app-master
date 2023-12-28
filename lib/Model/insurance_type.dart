class MyInsurance {
  final String insuranceType, companyName, date, imageURL;
  MyInsurance({
    required this.companyName,
    required this.date,
    required this.insuranceType,
    required this.imageURL,
  });
}

List<MyInsurance> myInsuranceList = [
  MyInsurance(
    companyName: 'Libya RE Insurance',
    date: '15/5/2023',
    insuranceType: 'Health insurance',
    imageURL: 'images/LIBYA RE INSURANCE.png',
  ),
  MyInsurance(
    companyName: 'Al Mohands',
    date: '25/5/2023',
    insuranceType: 'Car insurance',
    imageURL: 'images/ALMOHANDS.png',
  ),
  MyInsurance(
    companyName: 'Al Watheka',
    date: '30/4/2023',
    insuranceType: 'House insurance',
    imageURL: 'images/ALWATHEKA.png',
  ),
  MyInsurance(
    companyName: 'Al Barak',
    date: '10/4/2023',
    insuranceType: 'Product insurance',
    imageURL: 'images/Al Baraka.png',
  ),
  MyInsurance(
    companyName: 'Watanya',
    date: '6/5/2023',
    insuranceType: 'Life insurance',
    imageURL: 'images/watanya.png',
  ),
];
