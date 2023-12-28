import 'package:flutter/material.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Insurance_details/flood_pdf_screen.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/Model/companies_model.dart';

class FloodInsurance extends StatefulWidget {
  FloodInsurance({
    super.key,
  });

  @override
  State<FloodInsurance> createState() => _FloodInsuranceState();
}

class _FloodInsuranceState extends State<FloodInsurance> {
  var policyNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyNumber = Provider.of<InsuranceProvider>(context, listen: false)
        .generateRandomInsuranceNumber();
  }

  FocusNode _propertyDescriptionFocusNode = FocusNode();
  FocusNode _floodPreventionMeasuresFocusNode = FocusNode();

  TextEditingController _propertyDescriptionController =
      TextEditingController();
  TextEditingController _FloodPreventionMeasuresController =
      TextEditingController();

  TextEditingController beneficiaryNameController = TextEditingController();
  TextEditingController relationshipToInsuredController =
      TextEditingController();
  FocusNode beneficiaryNameFocusNode = FocusNode();
  FocusNode relationshipToInsuredFocusNode = FocusNode();

  void _submitForm(insuranceProvider, double insurancePrice) {
    final enteredData = {
      'insuranceType': insuranceProvider.insuranceData['insurance type'],
      'companyName': insuranceProvider.insuranceData['company'],
      'FloodZone': insuranceProvider.selectedFloodZone,
      'PropertyDescription': _propertyDescriptionController.text,
      'floodPreventionMeasures': _FloodPreventionMeasuresController.text,
      'LowerLevels': insuranceProvider.selectedHasLowerLevels,
      'flood Warning': insuranceProvider.selectedFloodWarning,
      'start date': insuranceProvider.date,
      'insurance price': insurancePrice,
      'insurance number': policyNumber,
      'expiration date': insuranceProvider.expirationDate,
      'ThirdParty': insuranceProvider.selectedThirdParty,
      'Beneficiary Name': beneficiaryNameController.text,
      'Relationship to Insured': relationshipToInsuredController.text,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FloodPdfScreen(fieldData: enteredData),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
    final floodZoneList = newInsuranceProvider.getFloodZone();
    final lowerLevelsList = newInsuranceProvider.getHasLowerLevels();
    final floodWarningList = newInsuranceProvider.getFloodWarning();
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
            value: newInsuranceProvider.selectedFloodZone,
            hint: Text('Flood Zone'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedFloodZone(value);
              }
            },
            items: floodZoneList.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _propertyDescriptionFocusNode,
            controller: _propertyDescriptionController,
            icon: Icons.home,
            isPassword: false,
            text: 'Property Description',
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
            value: newInsuranceProvider.selectedHasLowerLevels,
            hint: Text('Has Lower Levels?'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedHasLowerLevels(value);
              }
            },
            items: lowerLevelsList.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
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
            value: newInsuranceProvider.selectedFloodWarning,
            hint: Text('Flood Warning'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedFloodWarning(value);
              }
            },
            items: floodWarningList.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _floodPreventionMeasuresFocusNode,
            controller: _FloodPreventionMeasuresController,
            icon: Icons.flood,
            isPassword: false,
            text: 'Flood Prevention Measures',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
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

                _submitForm(newInsuranceProvider, insurancePrice);
                newInsuranceProvider.resetSelectedValues();
              }
            },
          ),
        ],
      ),
    );
  }
}
