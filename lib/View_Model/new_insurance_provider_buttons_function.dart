import 'package:flutter/material.dart';
import 'package:insurance_app/Model/companies_model.dart';
import 'package:intl/intl.dart';

class NewInsuranceProviderButtonFunctions extends ChangeNotifier {
  Company? _selectedCompany;
  InsuranceType? _selectedInsuranceType;

  Company? get selectedCompany => _selectedCompany;
  InsuranceType? get selectedInsuranceType => _selectedInsuranceType;
  Map<String, dynamic> insuranceData = {};

  String? _selectedStatus;
  String? _selectedTitle;
  String? _selectedlifePlan;
  String? _selectedHomeRentOwned;
  String? _selectedHomeType;
  String? _selectedBuildingType;
  String? _selectedNumberOfStories;
  String? _selectedLivesInHome;
  String? _selectedConstructionType;
  String? _selectedExteriorInteriorcondition;
  String? _selectedHomeSafety;
  String? _selectedCarInsuranceLocation;
  double? _numberOfChildren;
  String? _selectedSmokeDetectore;
  String? _selectedFireExtinguishers;
  String? _selectedSprinklers;
  String? _selectedFireAlarm;
  String? _selectedAdditionalFireInsurance;

  String? _selectedPeriodOfCoverage;
  String? _selectedPersonAge;
  String? _selectedIndividualOrFamily;

  String? _selectedFloodZone;
  String? _selectedFloodWarning;
  String? _selectedHasLowerLevels;

  String? _selectedEmploymentStatus;
  String? _selectedIncomeDetails;
  String? _selectedBenifitPeriod;

  String? _selectedCarInsuranceTime;
  String? _selectedPaymentFrequency;

  String? _selectedThirdInsuranceType;

  String? _selectedThirdParty;

  String? get selectedThirdInsuranceType => _selectedThirdInsuranceType;

  String? get selectedThirdParty => _selectedThirdParty;

  String? get selectedPaymentFrequency => _selectedPaymentFrequency;

  String? get selectedFloodZone => _selectedFloodZone;
  String? get selectedFloodWarning => _selectedFloodWarning;
  String? get selectedHasLowerLevels => _selectedHasLowerLevels;

  String? get selectedCarInsuranceTime => _selectedCarInsuranceTime;

  String? get selectedEmploymentStatus => _selectedEmploymentStatus;
  String? get selectedincomeDetails => _selectedIncomeDetails;
  String? get selectedBenifitPeriod => _selectedBenifitPeriod;

  String? get selectedSmokeDetectore => _selectedSmokeDetectore;
  String? get selectedFireExtinguishers => _selectedFireExtinguishers;
  String? get selectedSprinklers => _selectedSprinklers;
  String? get selectedFireAlarm => _selectedFireAlarm;
  String? get selectedAdditionalFireInsurance =>
      _selectedAdditionalFireInsurance;
  String? get selectedPeriodOfCoverage => _selectedPeriodOfCoverage;
  String? get selectedPersonAge => _selectedPersonAge;
  String? get selectedIndividualOrFamily => _selectedIndividualOrFamily;
  String? get selectedStatus => _selectedStatus;
  String? get selectedTitle => _selectedTitle;
  String? get selectedlifePlane => _selectedlifePlan;
  String? get selectedHomeRentOwned => _selectedHomeRentOwned;
  String? get selectedHomeType => _selectedHomeType;
  String? get selectedBuildingType => _selectedBuildingType;
  String? get selectedNumberOfStories => _selectedNumberOfStories;
  String? get selectedLivesInHome => _selectedLivesInHome;
  String? get selectedConstructionType => _selectedConstructionType;
  String? get selectedHomeSafety => _selectedHomeSafety;
  String? get selectedCarInsuranceLocation => _selectedCarInsuranceLocation;
  String? get selectedExteriorInteriorcondition =>
      _selectedExteriorInteriorcondition;
  double? get numberOfChildren => _numberOfChildren;

  List<String> paymentFrequency = ['Monthly', 'Annually'];

  List<String> SmokeDetectore = ['Yes', 'No'];
  List<String> FireExtinguishers = ['Yes', 'No'];
  List<String> Sprinklers = ['Yes', 'No'];
  List<String> AdditionalFireInsurance = ['Yes', 'No'];
  List<String> FireAlarm = ['Yes', 'No'];

  List<String> thirdParty = ['Yes', 'No'];

  List<String> FloodWarning = ['Yes', 'No'];
  List<String> hasLowerLevels = ['Basement', 'Lower Levels'];

  List<String> carInsuranceTimeList = [
    '3 Days',
    '1 Week',
    '2 Weeks',
    '1 Month',
    '2 Months',
    '3 Months',
  ];

  List<String> incomeDetails = ['Salary', 'Hourly Rate'];
  List<String> employmentStatus = ['Full-time', 'Part-time', 'Self-employed'];
  List<String> benifitPeriod = ['2 years', '5 years', 'retirement'];

  List<String> floodZoneOptions = [
    'Zone A (High flood risk)',
    'Zone B (Moderate flood risk)',
    'Zone C (Low flood risk)',
    'Zone D (Undetermined flood risk)',
    'Zone X (Outside the designated flood zones)',
    'Special Flood Hazard Area (SFHA)',
  ];

  List<String> periodOfCoverage = [
    '1 Week',
    '10 Days',
    '3 Weeks',
    '1 Month',
    '3 Months',
  ];

  List<String> personAge = [
    'From 1 to 10',
    'From 10 to 20',
    'From 20 to 65',
  ];

  List<String> individualOrFamily = [
    'Individual',
    'Family',
  ];

  List<double?> childrenNumber = [1, 2, 3, 4, 5];
  List<String> carInsuranceLocation = ['European Union', 'Rest of the World'];
  List<String> status = ['Married', 'Single'];
  List<String> title = ['Partner', 'Child'];
  List<String> lifePlan = ['5-years', '10-years', 'Whole life'];
  List<String> homeOwnedRent = ['Rent', 'Owned'];
  List<String> homeType = [
    'Home',
    'Store',
    'Empty House',
    'School',
  ];

  List<String> numberOfStories = ['1', '2', '3', '4'];
  List<String> livesInHome = [
    'Just me',
    'We\'re a couple',
    'Couple with children',
    'My children and I',
  ];

  List<String> exteriorInteriorcondition = [
    'Needs work',
    'Standard',
    'Good',
    'Excellent',
  ];

  List<String> constructionType = [
    'Brick',
    'Non-Combustible',
    'Masonry Non-Combustible',
    'Fire Resistive',
  ];

  List<String> homeSafety = [
    'Fire alarm',
    'Burglar alarm',
    'Cameras',
    'No safety',
  ];

  List<String> insurancesTypes = [
    'Health Insurance',
    'Car Insurance',
    'Life Insurance',
    'Property Insurance',
    'Travel Insurance',
    'Flood Insurance',
    'Business interruption Insurance',
    'Income protection Insurance',
  ];

  // List<Companies> companiesList = [
  //   Companies(
  //     companyName: 'Al Namaa',
  //     imageURL: 'images/2012177_logo_1531721978_n.png',
  //     insuranceType: [
  //       InsuranceType(name: 'Health Insurance', price: 40),
  //       InsuranceType(name: 'Car Insurance', price: 100),
  //       InsuranceType(name: 'Life Insurance', price: 200),
  //       InsuranceType(name: 'Property Insurance', price: 250),
  //     ],
  //   ),
  //   Companies(
  //     companyName: 'Al Baraka',
  //     imageURL: 'images/Al Baraka.png',
  //     insuranceType: [
  //       InsuranceType(name: 'Health Insurance', price: 40),
  //       InsuranceType(name: 'Travel Insurance', price: 150),
  //       InsuranceType(name: 'Property Insurance', price: 250),
  //     ],
  //   ),
  //   Companies(
  //     companyName: 'ALWATHEKA',
  //     imageURL: 'images/ALWATHEKA.png',
  //     insuranceType: [
  //       InsuranceType(name: 'Property Insurance', price: 140),
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
  List<InsuranceType> insuranceTypes = [
    InsuranceType(
      name: 'Health Insurance',
      companies: [
        Company(
          companyName: 'Company 1',
          imageURL: 'images/al_namaa_logo.png',
          price: 40,
        ),
        Company(
          companyName: 'Company 2',
          imageURL: 'images/watanya_logo.png',
          price: 40,
        ),
        Company(
          companyName: 'Alwatheka',
          imageURL: 'images/Al Baraka.png',
          price: 40,
        ),
        Company(
          companyName: 'Qafela',
          imageURL: 'images/qafela_insurance.png',
          price: 40,
        ),
      ],
    ),
    InsuranceType(
      name: 'Car Insurance',
      companies: [
        Company(
          companyName: 'Company 1',
          imageURL: 'images/al_namaa_logo.png',
          price: 100,
        ),
        Company(
          companyName: 'Company 4',
          imageURL: 'images/ALWATHEKA.png',
          price: 100,
        ),
        Company(
          companyName: 'Alwatheka',
          imageURL: 'images/Al Baraka.png',
          price: 100,
        ),
        Company(
          companyName: 'Qafela',
          imageURL: 'images/qafela_insurance.png',
          price: 40,
        ),
      ],
    ),
    InsuranceType(
      name: 'Life Insurance',
      companies: [
        Company(
          companyName: 'Company 1',
          imageURL: 'images/al_namaa_logo.png',
          price: 200,
        ),
        Company(
          companyName: 'Company 2',
          imageURL: 'images/Al Baraka.png',
          price: 200,
        ),
        Company(
          companyName: 'Alwatheka',
          imageURL: 'images/ALWATHEKA.png',
          price: 200,
        ),
        Company(
          companyName: 'Qafela',
          imageURL: 'images/qafela_insurance.png',
          price: 40,
        ),
      ],
    ),
    InsuranceType(
      name: 'Property Insurance',
      companies: [
        Company(
          companyName: 'Company 1',
          imageURL: 'images/al_namaa_logo.png',
          price: 250,
        ),
        Company(
          companyName: 'Company 2',
          imageURL: 'images/Al Baraka.png',
          price: 250,
        ),
        Company(
          companyName: 'Alwatheka',
          imageURL: 'images/watanya_logo.png',
          price: 250,
        ),
        Company(
          companyName: 'Qafela',
          imageURL: 'images/qafela_insurance.png',
          price: 40,
        ),
      ],
    ),
    InsuranceType(
      name: 'Travel Insurance',
      companies: [
        Company(
          companyName: 'Company 2',
          imageURL: 'images/Al Baraka.png',
          price: 150,
        ),
        Company(
          companyName: 'Alwatheka',
          imageURL: 'images/watanya_logo.png',
          price: 150,
        ),
        Company(
          companyName: 'Qafela',
          imageURL: 'images/qafela_insurance.png',
          price: 40,
        ),
      ],
    ),
    InsuranceType(
      name: 'Flood Insurance',
      companies: [
        Company(
          companyName: 'Company 2',
          imageURL: 'images/Al Baraka.png',
          price: 300,
        ),
        Company(
          companyName: 'Alwatheka',
          imageURL: 'images/watanya_logo.png',
          price: 300,
        ),
        // ... other companies for Flood Insurance
      ],
    ),
    InsuranceType(
      name: 'Business interruption Insurance',
      companies: [
        Company(
          companyName: 'Alwatheka',
          imageURL: 'images/watanya_logo.png',
          price: 800,
        ),
        Company(
          companyName: 'Qafela',
          imageURL: 'images/qafela_insurance.png',
          price: 40,
        ),
        // ... other companies for Business interruption Insurance
      ],
    ),
    InsuranceType(
      name: 'Income protection Insurance',
      companies: [
        Company(
          companyName: 'Alwatheka',
          imageURL: 'images/watanya_logo.png',
          price: 740,
        ),
        Company(
          companyName: 'Company 1',
          imageURL: 'images/al_namaa_logo.png',
          price: 740,
        ),
        Company(
          companyName: 'Qafela',
          imageURL: 'images/qafela_insurance.png',
          price: 40,
        ),
      ],
    ),
  ];

  String? validateEmpty(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  void calculateAdditionalAmount() {
    if (_selectedInsuranceType?.name == 'Life Insurance') {
      if (_selectedlifePlan == '5-years') {
        selectedCompany!.price = 200;
      }
      if (_selectedlifePlan == '10-years') {
        selectedCompany!.price = 400;
      } else if (_selectedlifePlan == 'Whole life') {
        selectedCompany!.price = 600;
      }
    }
    notifyListeners();
  }

  void calculateCarTimePrice() {
    if (_selectedInsuranceType?.name == 'Car Insurance') {
      if (_selectedCarInsuranceTime == '3 Days') {
        selectedCompany!.price = 100;
      } else if (_selectedCarInsuranceTime == '1 Week') {
        selectedCompany!.price = 150;
      } else if (_selectedCarInsuranceTime == '10 Days') {
        selectedCompany!.price = 200;
      } else if (_selectedCarInsuranceTime == '2 Weeks') {
        selectedCompany!.price = 250;
      } else if (_selectedCarInsuranceTime == '1 Month') {
        selectedCompany!.price = 350;
      } else if (_selectedCarInsuranceTime == '2 Months') {
        selectedCompany!.price = 450;
      } else if (_selectedCarInsuranceTime == '3 Months') {
        selectedCompany!.price = 550;
      }
    }
    notifyListeners();
  }

  void setSelectedCarInsuranceTime(String time) {
    if (_selectedCarInsuranceTime != time) {
      _selectedCarInsuranceTime = time;
    }
    print(_selectedCarInsuranceTime);
    notifyListeners();
  }

  void setSelectedInsuranceType(InsuranceType? insuranceType) {
    _selectedInsuranceType = insuranceType;
    insuranceData['insurance type'] = _selectedInsuranceType?.name;
    _selectedCompany = null;
    print(insuranceData);
    notifyListeners();
  }

  void setSelectedCompany(Company? company) {
    _selectedCompany = company;
    insuranceData['company'] = _selectedCompany?.companyName;
    print(insuranceData);
    notifyListeners();
  }

  void resetSelectedValues() {
    _selectedInsuranceType = null;
    _selectedCompany = null;
    insuranceData['insurance type'] = null;
    insuranceData['company'] = null;
    _selectedStatus = null;
    _selectedTitle = null;
    _selectedlifePlan = null;
    _selectedHomeRentOwned = null;
    _selectedHomeType = null;
    _selectedBuildingType = null;
    _selectedNumberOfStories = null;
    _selectedLivesInHome = null;
    _selectedConstructionType = null;
    _selectedExteriorInteriorcondition = null;
    _selectedHomeSafety = null;
    _selectedCarInsuranceLocation = null;
    _numberOfChildren = null;
    _selectedSmokeDetectore = null;
    _selectedFireExtinguishers = null;
    _selectedSprinklers = null;
    _selectedFireAlarm = null;
    _selectedAdditionalFireInsurance = null;

    _selectedPeriodOfCoverage = null;
    _selectedPersonAge = null;
    _selectedIndividualOrFamily = null;

    _selectedFloodZone = null;
    _selectedFloodWarning = null;
    _selectedHasLowerLevels = null;

    _selectedEmploymentStatus = null;
    _selectedIncomeDetails = null;
    _selectedBenifitPeriod = null;

    _selectedCarInsuranceTime = null;
    print(insuranceData);
    notifyListeners();
  }

  // void setSelectedCompany(Companies company) {
  //   if (_selectedCompany != company) {
  //     _selectedCompany = company;
  //     _selectedInsuranceType = null;
  //     insuranceData.addEntries({
  //       MapEntry('company', _selectedCompany!.companyName),
  //     });
  //     print(insuranceData);
  //     notifyListeners();
  //   }
  // }

  void setSelectedStatus(String? status) {
    if (_selectedStatus != status) {
      _selectedStatus = status;
    }
    print(_selectedStatus);
    notifyListeners();
  }

  void setSelectedSmokeDetector(String? smoke) {
    if (_selectedSmokeDetectore != smoke) {
      _selectedSmokeDetectore = smoke;
    }
    print(_selectedSmokeDetectore);
    notifyListeners();
  }

  void setSelectedFireExtinguisher(String? fireExting) {
    if (_selectedFireExtinguishers != fireExting) {
      _selectedFireExtinguishers = fireExting;
    }
    print(_selectedFireExtinguishers);
    notifyListeners();
  }

  void setSelectedSprinklers(String? sprinkler) {
    if (_selectedSprinklers != sprinkler) _selectedSprinklers = sprinkler;
    print(_selectedSprinklers);
    notifyListeners();
  }

  void setSelectedInsuranceThirdType(String? type) {
    if (_selectedThirdInsuranceType != type) _selectedThirdInsuranceType = type;
    print(_selectedThirdInsuranceType);
    notifyListeners();
  }

  void setSelectedFireAlarm(String? alarm) {
    if (_selectedFireAlarm != alarm) _selectedFireAlarm = alarm;
    print(_selectedFireAlarm);
    notifyListeners();
  }

  void setSelectedAdditionalFireInsurance(String? fireinsu) {
    if (_selectedAdditionalFireInsurance != fireinsu)
      _selectedAdditionalFireInsurance = fireinsu;
    print(_selectedAdditionalFireInsurance);
    notifyListeners();
  }

  void setSelectedCoverageAge(String? covetageAge) {
    if (_selectedPeriodOfCoverage != covetageAge) {
      _selectedPeriodOfCoverage = covetageAge;
    }
    print(_selectedPeriodOfCoverage);
    notifyListeners();
  }

  void setSelectedPersonAge(String? age) {
    if (_selectedPersonAge != age) {
      _selectedPersonAge = age;
    }
    print(_selectedPersonAge);
    notifyListeners();
  }

  void setThirdParty(String? party) {
    if (_selectedThirdParty != party) _selectedThirdParty = party;
    print(_selectedThirdParty);
    notifyListeners();
  }

  void setSelectedIndividualOrFamily(String? indFam) {
    if (_selectedIndividualOrFamily != indFam) {
      _selectedIndividualOrFamily = indFam;
    }
    print(_selectedIndividualOrFamily);
    notifyListeners();
  }

  void setSelectedTitle(String? title) {
    if (_selectedTitle != title) {
      _selectedTitle = title;
    }
    print(_selectedTitle);
    notifyListeners();
  }

  void setSelectedLifePlane(String? lifePlane) {
    if (_selectedlifePlan != lifePlan) {
      _selectedlifePlan = lifePlane;
    }
    print(_selectedlifePlan);
    notifyListeners();
  }

  void setSelectedHomeType(String? homeType) {
    if (_selectedHomeType != homeType) {
      _selectedHomeType = homeType;
    }
    print(_selectedHomeType);
    notifyListeners();
  }

  void setSelectedHomeRentOwned(String? HomeRentOwned) {
    if (_selectedHomeRentOwned != HomeRentOwned) {
      _selectedHomeRentOwned = HomeRentOwned;
    }
    print(_selectedHomeRentOwned);
    notifyListeners();
  }

  void setSelectedBuildingtype(String? buildingType) {
    if (_selectedBuildingType != buildingType) {
      _selectedBuildingType = buildingType;
    }
    print(_selectedBuildingType);
    notifyListeners();
  }

  void setSelectedNumberOfStories(String? number) {
    if (_selectedNumberOfStories != number) {
      _selectedNumberOfStories = number;
    }
    print(_selectedNumberOfStories);
    notifyListeners();
  }

  void setSelectedNumberinHome(String? inHome) {
    if (_selectedLivesInHome != inHome) {
      _selectedLivesInHome = inHome;
    }
    print(_selectedLivesInHome);
    notifyListeners();
  }

  void setSelectedExtiriotInterior(String? eI) {
    if (_selectedExteriorInteriorcondition != eI) {
      _selectedExteriorInteriorcondition = eI;
    }
    print(_selectedExteriorInteriorcondition);
    notifyListeners();
  }

  void setSelectedConstructionType(String? Constype) {
    if (_selectedConstructionType != Constype) {
      _selectedConstructionType = Constype;
    }
    print(_selectedConstructionType);
    notifyListeners();
  }

  void setHomeSafety(String? safety) {
    if (_selectedHomeSafety != safety) {
      _selectedHomeSafety = safety;
    }
    print(_selectedHomeSafety);
    notifyListeners();
  }

  void setChildrenNumber(double? childrenNo) {
    if (_numberOfChildren != childrenNo) {
      _numberOfChildren = childrenNo;
    }
    print(_numberOfChildren);
    notifyListeners();
  }

  void setPaymentFrequency(String? payment) {
    if (_selectedPaymentFrequency != payment) {
      _selectedPaymentFrequency = payment;
    }
    print(_selectedPaymentFrequency);
    notifyListeners();
  }

  // void setSelectedInsuranceType(InsuranceType? insuranceType) {
  //   _selectedInsuranceType = insuranceType;
  //   insuranceData['insurance type'] = _selectedInsuranceType?.name;
  //   print(insuranceData);
  //   notifyListeners();
  // }

  // void setSelectedInsuranceType(InsuranceType? insuranceType) {
  //   _selectedCompany =
  //       null; // Reset the selected company when a new insurance type is selected
  //   _selectedInsuranceType = insuranceType;
  //   insuranceData['insurance type'] = _selectedInsuranceType?.name;
  //   notifyListeners();
  // }

  void setSelectedFloodZone(String? floodZone) {
    if (_selectedFloodZone != floodZone) _selectedFloodZone = floodZone;
    print(_selectedFloodZone);
    notifyListeners();
  }

  void setSelectedHasLowerLevels(String? lowerLevels) {
    if (_selectedHasLowerLevels != lowerLevels)
      _selectedHasLowerLevels = lowerLevels;
    print(_selectedHasLowerLevels);
    notifyListeners();
  }

  void setSelectedFloodWarning(String? warning) {
    if (_selectedFloodWarning != warning) _selectedFloodWarning = warning;
    print(_selectedFloodWarning);
    notifyListeners();
  }

  void setSelectedEmploymentStatus(String? employ) {
    if (_selectedEmploymentStatus != employ) _selectedEmploymentStatus = employ;
    print(_selectedEmploymentStatus);
    notifyListeners();
  }

  void setSelectedIncomeDetails(String? income) {
    if (_selectedIncomeDetails != income) _selectedIncomeDetails;
    print(_selectedIncomeDetails);
    notifyListeners();
  }

  void setSelectedBenifitPeriod(String? benifit) {
    if (_selectedBenifitPeriod != benifit) _selectedBenifitPeriod;
    print(_selectedBenifitPeriod);
    notifyListeners();
  }

  // void setSelectedInsuranceType(InsuranceType insuranceType) {
  //   _selectedInsuranceType = insuranceType;
  //   insuranceData.addEntries({
  //     MapEntry('insurance type', _selectedInsuranceType!.name),
  //   });
  //   print(insuranceData);
  //   notifyListeners();
  // }

  List<String> getInsuranceThirdType() {
    return insurancesTypes;
  }

  List<String> getPaymentFrequency() {
    return paymentFrequency;
  }

  List<String> getBenifitPeriod() {
    return benifitPeriod;
  }

  List<String> getFloodWarning() {
    return FloodWarning;
  }

  List<String> getHasLowerLevels() {
    return hasLowerLevels;
  }

  List<String> getThridParty() {
    return thirdParty;
  }

  List<String> getFloodZone() {
    return floodZoneOptions;
  }

  List<double?> getChildrenNumber() {
    return childrenNumber;
  }

  List<Company> getCompaniesForInsuranceType() {
    if (_selectedInsuranceType == null) {
      return [];
    }
    return _selectedInsuranceType!.companies;
  }

  List<String> getCarInsuranceTime() {
    return carInsuranceTimeList;
  }

  List<String> gethomeType() {
    return homeType;
  }

  List<String> getnumberOfStories() {
    return numberOfStories;
  }

  List<String> getEmploymentStatus() {
    return employmentStatus;
  }

  List<String> gethomeSafety() {
    return homeSafety;
  }

  List<String> getIncomeDetails() {
    return incomeDetails;
  }

  List<String> getPeriodOfCoverage() {
    return periodOfCoverage;
  }

  List<String> getAdditionalFireInsurance() {
    return AdditionalFireInsurance;
  }

  List<String> getSmokeDetectors() {
    return SmokeDetectore;
  }

  List<String> getFireExtinguisher() {
    return FireExtinguishers;
  }

  List<String> getFireAlarm() {
    return FireAlarm;
  }

  List<String> getSprinklers() {
    return Sprinklers;
  }

  List<String> getPersonAge() {
    return personAge;
  }

  List<String> getIndividualOrFamily() {
    return individualOrFamily;
  }

  List<String> getHomeOwnedRent() {
    return homeOwnedRent;
  }

  List<String> getlivesInHome() {
    return livesInHome;
  }

  List<String> getconstructionType() {
    return constructionType;
  }

  List<String> getexteriorInteriorcondition() {
    return exteriorInteriorcondition;
  }

  List<String> getLifePlan() {
    return lifePlan;
  }

  List<String> getTitles() {
    return title;
  }

  List<String> getStatus() {
    return status;
  }

  List<InsuranceType> getInsuranceType() {
    return insuranceTypes;
  }

  DateTime selectedDate = DateTime.now();
  DateTime selectedTravelDate = DateTime.now();

  String? date, travelDate, expirationDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1940),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;

      // Calculate the expiration date as 6 months from the selected date
      final expirationDuration = Duration(days: 6 * 30); // 6 months = 180 days
      final expirationDateTime = selectedDate.add(expirationDuration);
      expirationDate = DateFormat('yyyy-MM-dd').format(expirationDateTime);

      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      date = formattedDate.toString();
      notifyListeners();
    }
  }

  Future<void> selectTravelDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedTravelDate,
        firstDate: DateTime(1940),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedTravelDate) {
      selectedTravelDate = picked;
      final formattedTravelDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      travelDate = formattedTravelDate.toString();
      notifyListeners();
    }
  }
}
