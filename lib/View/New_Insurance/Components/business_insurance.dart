import 'package:flutter/material.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Insurance_details/business_pdf_screen.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/Model/companies_model.dart';

class BusinessInsurance extends StatefulWidget {
  BusinessInsurance({
    super.key,
  });

  @override
  State<BusinessInsurance> createState() => _BusinessInsuranceState();
}

class _BusinessInsuranceState extends State<BusinessInsurance> {
  var policyNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyNumber = Provider.of<InsuranceProvider>(context, listen: false)
        .generateRandomInsuranceNumber();
  }

  FocusNode _businessNameFocusNode = FocusNode();
  FocusNode _businessAddressFocusNode = FocusNode();
  FocusNode _businessNatureFocusNode = FocusNode();
  FocusNode _businessSectorFocusNode = FocusNode();
  FocusNode _numberOfEmployeesFocusNode = FocusNode();
  FocusNode _annualRevenueFocusNode = FocusNode();
  FocusNode _riskManagementFocusNode = FocusNode();

  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _businessAddressController = TextEditingController();
  TextEditingController _businessNatureController = TextEditingController();
  TextEditingController _businessSectoreController = TextEditingController();
  TextEditingController _numberOfEmployeesController = TextEditingController();
  TextEditingController _annualRevenueController = TextEditingController();
  TextEditingController _riskManagementController = TextEditingController();

  TextEditingController beneficiaryNameController = TextEditingController();
  TextEditingController relationshipToInsuredController =
      TextEditingController();
  FocusNode beneficiaryNameFocusNode = FocusNode();
  FocusNode relationshipToInsuredFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  void _submit(newInsuranceProvider, double insurancePrice) {
    final enteredData = {
      'insuranceType': newInsuranceProvider.insuranceData['insurance type'],
      'companyName': newInsuranceProvider.insuranceData['company'],
      'start date': newInsuranceProvider.date,
      'business name': _businessNameController.text,
      'business address': _businessAddressController.text,
      'business nature': _businessNatureController.text,
      'business sectore': _businessSectoreController.text,
      'number of employees': _numberOfEmployeesController.text,
      'annual revenue': _annualRevenueController.text,
      'risk management': _riskManagementController.text,
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
        builder: (context) => BusinessPdfScreen(
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
    final thirdParty = newInsuranceProvider.getThridParty();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyTextField(
            focusNode: _businessNameFocusNode,
            controller: _businessNameController,
            icon: Icons.business,
            isPassword: false,
            text: 'Business Name',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _businessAddressFocusNode,
            controller: _businessAddressController,
            icon: Icons.pin_drop_outlined,
            isPassword: false,
            text: 'Business Address',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _businessNatureFocusNode,
            controller: _businessNatureController,
            icon: Icons.business_center_outlined,
            isPassword: false,
            text: 'Business Nature',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _businessSectorFocusNode,
            controller: _businessSectoreController,
            icon: Icons.class_outlined,
            isPassword: false,
            text: 'Business Sectore',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _numberOfEmployeesFocusNode,
            controller: _numberOfEmployeesController,
            icon: Icons.person_2,
            isPassword: false,
            text: 'Number of employees you have',
            textInputType: TextInputType.number,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _annualRevenueFocusNode,
            controller: _annualRevenueController,
            icon: Icons.money,
            isPassword: false,
            text: 'Annual Revenue',
            textInputType: TextInputType.number,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _riskManagementFocusNode,
            controller: _riskManagementController,
            icon: Icons.dangerous,
            isPassword: false,
            text: 'What is your risk management',
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
