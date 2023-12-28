import 'package:flutter/material.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Insurance_details/health_pdf_screen.dart';
import 'package:insurance_app/View_Model/auth_provider.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/Model/companies_model.dart';

class HealthInsurance extends StatefulWidget {
  HealthInsurance({
    super.key,
  });

  @override
  State<HealthInsurance> createState() => _HealthInsuranceState();
}

class _HealthInsuranceState extends State<HealthInsurance> {
  var policyNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyNumber = Provider.of<InsuranceProvider>(context, listen: false)
        .generateRandomInsuranceNumber();
  }

  FocusNode healthInformation = FocusNode();

  FocusNode familyNumberFocusNode = FocusNode();

  FocusNode addressFocusNode = FocusNode();

  FocusNode partnerChildFocusNode = FocusNode();

  FocusNode partnerChildAgeFocusNode = FocusNode();

  FocusNode cityFocusNode = FocusNode();

  TextEditingController beneficiaryNameController = TextEditingController();
  TextEditingController relationshipToInsuredController =
      TextEditingController();
  FocusNode beneficiaryNameFocusNode = FocusNode();
  FocusNode relationshipToInsuredFocusNode = FocusNode();

  TextEditingController _healthInformationController = TextEditingController();

  TextEditingController _familyGovNumberController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  TextEditingController _cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
    final statusList = newInsuranceProvider.getStatus();
    final paymentList = newInsuranceProvider.getPaymentFrequency();
    final thirdParty = newInsuranceProvider.getThridParty();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyTextField(
            focusNode: healthInformation,
            controller: _healthInformationController,
            icon: Icons.health_and_safety,
            isPassword: false,
            text: 'Health info',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: familyNumberFocusNode,
            controller: _familyGovNumberController,
            icon: Icons.family_restroom,
            isPassword: false,
            text: 'Family Gov Number',
            textInputType: TextInputType.number,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: addressFocusNode,
            controller: _addressController,
            icon: Icons.location_pin,
            isPassword: false,
            text: 'Address',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: cityFocusNode,
            controller: _cityController,
            icon: Icons.location_city,
            isPassword: false,
            text: 'City',
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
            value: newInsuranceProvider.selectedPaymentFrequency,
            hint: Text('Payment Frequency'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setPaymentFrequency(value);
              }
            },
            items: paymentList.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
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
            value: newInsuranceProvider.selectedStatus,
            hint: Text('Choose Status'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedStatus(value);
              }
            },
            items: statusList.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          if (context
                  .watch<NewInsuranceProviderButtonFunctions>()
                  .selectedStatus ==
              'Married')
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Upload Family Handbook',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                // add upload button
                InkWell(
                  onTap: () {
                    Provider.of<LoginProvider>(context, listen: false)
                        .insurancePickUploadImage();
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 118, 200, 147),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ]),
                    child: Center(
                      child: Text(
                        'Upload',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

                _submitform(newInsuranceProvider, insurancePrice);
                newInsuranceProvider.resetSelectedValues();
              }
            },
          ),
        ],
      ),
    );
  }

  void _submitform(insuranceProvider, double insurancePrice) {
    final enteredData = {
      'insuranceType': insuranceProvider.insuranceData['insurance type'],
      'companyName': insuranceProvider.insuranceData['company'],
      'healthInfo': _healthInformationController.text,
      'familyNumber': _familyGovNumberController.text,
      'address': _addressController.text,
      'maritalStatus': insuranceProvider.selectedStatus,
      'start date': insuranceProvider.date,
      'insurance price': insurancePrice,
      'insurance number': policyNumber,
      'expiration date': insuranceProvider.expirationDate,
      'payment frequency': insuranceProvider.selectedPaymentFrequency,
      'imageUrl':
          Provider.of<LoginProvider>(context, listen: false).insuranceImageURL,
      'ThirdParty': insuranceProvider.selectedThirdParty,
      'Beneficiary Name': beneficiaryNameController.text,
      'Relationship to Insured': relationshipToInsuredController.text,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HealthPdfScreen(
          fieldData: enteredData,
        ),
      ),
    );
  }
}
