import 'package:flutter/material.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Insurance_details/travel_pdf_screen.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/Model/companies_model.dart';

class ThirdPartyInsurance extends StatefulWidget {
  ThirdPartyInsurance({
    super.key,
  });
  @override
  State<ThirdPartyInsurance> createState() => _ThirdPartyInsuranceState();
}

class _ThirdPartyInsuranceState extends State<ThirdPartyInsurance> {
  var policyNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyNumber = Provider.of<InsuranceProvider>(context, listen: false)
        .generateRandomInsuranceNumber();
  }

  TextEditingController beneficiaryNameController = TextEditingController();
  TextEditingController relationshipToInsuredController =
      TextEditingController();
  FocusNode beneficiaryNameFocusNode = FocusNode();
  FocusNode relationshipToInsuredFocusNode = FocusNode();

  void _submitForm(insuranceProvider, double insurancePrice) {
    final enteredData = {
      'insuranceType': insuranceProvider.insuranceData['insurance type'],
      'companyName': insuranceProvider.insuranceData['company'],
      'PeriodCoverage': insuranceProvider.selectedPeriodOfCoverage,
      'start date': insuranceProvider.date,
      'insurance price': insurancePrice,
      'expiration date': insuranceProvider.expirationDate,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TravelPdfScreen(fieldData: enteredData),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
    final insurancesType = newInsuranceProvider.getInsuranceThirdType();

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
            value: newInsuranceProvider.selectedThirdInsuranceType,
            hint: Text('Selected Insurance Type'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedInsuranceThirdType(value);
              }
            },
            items: insurancesType.map(
              (status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              },
            ).toList(),
          ),
          SizedBox(height: size.height * 0.02),
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
