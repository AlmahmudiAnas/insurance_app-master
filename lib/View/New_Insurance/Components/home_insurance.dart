import 'package:flutter/material.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Insurance_details/home_pdf_screen.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/Model/companies_model.dart';

class HomeInsurance extends StatefulWidget {
  HomeInsurance({
    super.key,
  });

  @override
  State<HomeInsurance> createState() => _HomeInsuranceState();
}

class _HomeInsuranceState extends State<HomeInsurance> {
  FocusNode squareKillos = FocusNode();
  FocusNode _fireEscapeRoute = FocusNode();
  FocusNode _previousFireIncident = FocusNode();

  TextEditingController _squareKillos = TextEditingController();
  TextEditingController _fireEscapeRouteController = TextEditingController();
  TextEditingController _previousFireIncidentController =
      TextEditingController();

  TextEditingController beneficiaryNameController = TextEditingController();
  TextEditingController relationshipToInsuredController =
      TextEditingController();
  FocusNode beneficiaryNameFocusNode = FocusNode();
  FocusNode relationshipToInsuredFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  var policyNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyNumber = Provider.of<InsuranceProvider>(context, listen: false)
        .generateRandomInsuranceNumber();
  }

  void _submit(newInsuranceProvider, double insurancePrice) {
    final enteredData = {
      'insuranceType': newInsuranceProvider.insuranceData['insurance type'],
      'companyName': newInsuranceProvider.insuranceData['company'],
      'houseOwned': newInsuranceProvider.selectedHomeRentOwned,
      'propertyType': newInsuranceProvider.selectedHomeType,
      'numberOfStories': newInsuranceProvider.selectedNumberOfStories,
      'squareKillos': _squareKillos.text,
      'livesInHome': newInsuranceProvider.selectedLivesInHome,
      'exteriorInteriorCondition':
          newInsuranceProvider.selectedExteriorInteriorcondition,
      'constructionType': newInsuranceProvider.selectedConstructionType,
      'homeSafety': newInsuranceProvider.selectedHomeSafety,
      'start date': newInsuranceProvider.date,
      'insurance price': insurancePrice,
      'insurance number': policyNumber,
      'expiration date': newInsuranceProvider.expirationDate,
      'ThirdParty': newInsuranceProvider.selectedThirdParty,
      'Beneficiary Name': beneficiaryNameController.text,
      'Relationship to Insured': relationshipToInsuredController.text,
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePdfScreen(
          fieldData: enteredData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);

    final homeRentOwnedList = newInsuranceProvider.getHomeOwnedRent();
    final homeTypeList = newInsuranceProvider.gethomeType();
    final numberOfStoriesList = newInsuranceProvider.getnumberOfStories();
    final livesInHouse = newInsuranceProvider.getlivesInHome();
    final constructionList = newInsuranceProvider.getconstructionType();
    final homeSafetyList = newInsuranceProvider.gethomeSafety();
    final exteriorInteriorconditionList =
        newInsuranceProvider.getexteriorInteriorcondition();
    final smokeDetectoresList = newInsuranceProvider.getSmokeDetectors();
    final fireExtinguisherList = newInsuranceProvider.getFireExtinguisher();
    final fireAlarmList = newInsuranceProvider.getFireAlarm();
    final SprinklerList = newInsuranceProvider.getSprinklers();
    final additionalFireInsurance =
        newInsuranceProvider.getAdditionalFireInsurance();
    final thirdParty = newInsuranceProvider.getThridParty();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedHomeRentOwned,
            hint: Text('Do you own your house'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedHomeRentOwned(value);
              }
            },
            items: homeRentOwnedList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedHomeType,
            hint: Text('What type of property is it?'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedHomeType(value);
              }
            },
            items: homeTypeList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedNumberOfStories,
            hint: Text('Number of stories?'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedNumberOfStories(value);
              }
            },
            items: numberOfStoriesList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: squareKillos,
            controller: _squareKillos,
            icon: Icons.square_foot_outlined,
            isPassword: false,
            text: 'What is the square killo of the house?',
            textInputType: TextInputType.number,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedLivesInHome,
            hint: Text('how many lives in the house?'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedNumberinHome(value);
              }
            },
            items: livesInHouse.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedExteriorInteriorcondition,
            hint: Text(
              'What is the condition of Exterior \& interior',
              style: TextStyle(fontSize: 15),
            ),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedExtiriotInterior(value);
              }
            },
            items: exteriorInteriorconditionList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedConstructionType,
            hint: Text('Type of construction'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedConstructionType(value);
              }
            },
            items: constructionList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedHomeSafety,
            hint: Text('Home Safety'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setHomeSafety(value);
              }
            },
            items: homeSafetyList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedSmokeDetectore,
            hint: Text('Any Smoke Detectors'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedSmokeDetector(value);
              }
            },
            items: smokeDetectoresList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedFireExtinguishers,
            hint: Text('Any Fire Extinguishers'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedFireExtinguisher(value);
              }
            },
            items: fireExtinguisherList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedSprinklers,
            hint: Text('You have Sprinklers?'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedSprinklers(value);
              }
            },
            items: SprinklerList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedFireAlarm,
            hint: Text('You have Fire alarm?'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedFireAlarm(value);
              }
            },
            items: fireAlarmList.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _fireEscapeRoute,
            controller: _fireEscapeRouteController,
            icon: Icons.explicit_outlined,
            isPassword: false,
            text: 'Descripe your fire escape route',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _previousFireIncident,
            controller: _previousFireIncidentController,
            icon: Icons.fireplace_outlined,
            isPassword: false,
            text: 'Previous Fire Incident',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedAdditionalFireInsurance,
            hint: Text('Do you want Fire Insurance?'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedAdditionalFireInsurance(value);
              }
            },
            items: additionalFireInsurance.map((title) {
              return DropdownMenuItem(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.01),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            value: newInsuranceProvider.selectedThirdParty,
            hint: Text('Want Third Party Insurance?'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setThirdParty(value);
              }
            },
            items: thirdParty.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          if (context
                  .watch<NewInsuranceProviderButtonFunctions>()
                  .selectedThirdParty ==
              'Yes')
            Column(
              children: [
                MyTextField(
                  focusNode: beneficiaryNameFocusNode,
                  controller: beneficiaryNameController,
                  icon: Icons.document_scanner,
                  isPassword: false,
                  text: 'Beneficiary Name',
                  textInputType: TextInputType.text,
                  validator: (value) {
                    return newInsuranceProvider.validateEmpty(value.toString());
                  },
                ),
                SizedBox(height: size.height * 0.02),
                MyTextField(
                  focusNode: relationshipToInsuredFocusNode,
                  controller: relationshipToInsuredController,
                  icon: Icons.document_scanner,
                  isPassword: false,
                  text: 'Relationship to Insured',
                  textInputType: TextInputType.text,
                  validator: (value) {
                    return newInsuranceProvider.validateEmpty(value.toString());
                  },
                ),
              ],
            ),
          SizedBox(height: size.height * 0.02),
          MyButton(
            size: size,
            text: 'Next',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newInsuranceProvider =
                    Provider.of<NewInsuranceProviderButtonFunctions>(context,
                        listen: false);

                final selectedInsuranceType =
                    newInsuranceProvider.selectedInsuranceType;
                final selectedCompany = newInsuranceProvider.selectedCompany;

                double insurancePrice = 0.0;

                if (selectedInsuranceType != null && selectedCompany != null) {
                  final matchingCompany =
                      selectedInsuranceType.companies.firstWhere(
                    (company) =>
                        company.companyName == selectedCompany.companyName,
                    orElse: () =>
                        Company(companyName: '', imageURL: '', price: 0.0),
                  );

                  insurancePrice = matchingCompany.price;
                }

                _submit(newInsuranceProvider, insurancePrice);
                newInsuranceProvider.resetSelectedValues();
              }
            },
          ),
        ],
      ),
    );
  }
}
