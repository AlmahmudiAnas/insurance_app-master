import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Insurance_details/life_pdf_screen.dart';
import 'package:insurance_app/View_Model/auth_provider.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/Model/companies_model.dart';

class LifeInsurance extends StatefulWidget {
  LifeInsurance({
    super.key,
  });

  @override
  State<LifeInsurance> createState() => _LifeInsuranceState();
}

class _LifeInsuranceState extends State<LifeInsurance> {
  final FocusNode heightFocusNode = FocusNode();
  final FocusNode weightFocusNode = FocusNode();
  final FocusNode healthIssuesFocusNode = FocusNode();
  final FocusNode additionalInfoFocusNode = FocusNode();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _healthIssuesController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  TextEditingController beneficiaryNameController = TextEditingController();
  TextEditingController relationshipToInsuredController =
      TextEditingController();
  FocusNode beneficiaryNameFocusNode = FocusNode();
  FocusNode relationshipToInsuredFocusNode = FocusNode();
  final Map<String, double> additionalAmounts = {
    '5 years': 0.0,
    '10 years': 200.0,
    'Whole life': 400.0,
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var policyNumber;

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      policyNumber = Provider.of<InsuranceProvider>(context, listen: false)
          .generateRandomInsuranceNumber();
    }

    void _submit(insuranceProvider, double insurancePrice) {
      final enteredData = {
        'insuranceType': insuranceProvider.insuranceData['insurance type'],
        'companyName': insuranceProvider.insuranceData['company'],
        'lifePlan': insuranceProvider.selectedlifePlane,
        'height': _heightController.text,
        'weight': _weightController.text,
        'healthIssues': _healthIssuesController.text,
        'additionalInfo': _additionalInfoController.text,
        'start date': insuranceProvider.date,
        'insurance price': insurancePrice,
        'insurance number': policyNumber,
        'expiration date': insuranceProvider.expirationDate,
        'imageUrl': Provider.of<LoginProvider>(context, listen: false)
            .insuranceImageURL,
        'ThirdParty': insuranceProvider.selectedThirdParty,
        'Beneficiary Name': beneficiaryNameController.text,
        'Relationship to Insured': relationshipToInsuredController.text,
      };
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LifePdfScreen(fieldData: enteredData),
        ),
      );
    }

    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
    Size size = MediaQuery.of(context).size;
    final lifePlaneList = newInsuranceProvider.getLifePlan();
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
            value: newInsuranceProvider.selectedlifePlane,
            hint: Text('Choose Life plane'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedLifePlane(value);
                newInsuranceProvider.calculateAdditionalAmount();
              }
            },
            items: lifePlaneList.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: heightFocusNode,
            controller: _heightController,
            icon: Icons.height,
            isPassword: false,
            text: 'Height',
            textInputType: TextInputType.number,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: weightFocusNode,
            controller: _weightController,
            icon: Icons.line_weight,
            isPassword: false,
            text: 'Weight',
            textInputType: TextInputType.number,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: healthIssuesFocusNode,
            controller: _healthIssuesController,
            icon: Icons.health_and_safety,
            isPassword: false,
            text: 'Any health issues?',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: additionalInfoFocusNode,
            controller: _additionalInfoController,
            icon: Icons.info,
            isPassword: false,
            text: 'Add any additional Info',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.height * 0.07,
                width: size.width * 0.4,
                child: Text(
                  'Upload a medical examination',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              context.watch<LoginProvider>().imageUploading
                  ? CircularProgressIndicator()
                  : Container(
                      width: size.width * 0.3,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Provider.of<LoginProvider>(context, listen: false)
                              .insurancePickUploadImage();
                        },
                        child: Text(
                          'Upload',
                          style: GoogleFonts.acme(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
            ],
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
