import 'package:flutter/material.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Insurance_details/income_pdf_screen.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/Model/companies_model.dart';

class IncomeInsurance extends StatefulWidget {
  IncomeInsurance({
    super.key,
  });

  @override
  State<IncomeInsurance> createState() => _IncomeInsuranceState();
}

class _IncomeInsuranceState extends State<IncomeInsurance> {
  var policyNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyNumber = Provider.of<InsuranceProvider>(context, listen: false)
        .generateRandomInsuranceNumber();
  }

  FocusNode _jobTitleFocusNode = FocusNode();
  FocusNode _desiredCoverageFocusNode = FocusNode();
  FocusNode _medicalHistoryFocusNode = FocusNode();
  FocusNode _smokingOrAlcoholFocusNode = FocusNode();
  FocusNode _beneficiaryFocusNode = FocusNode();

  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _desiredCoverageController = TextEditingController();
  TextEditingController _medicalHistoryController = TextEditingController();
  TextEditingController _smokingOrAlcoholController = TextEditingController();
  TextEditingController _beneficiaryController = TextEditingController();

  TextEditingController beneficiaryNameController = TextEditingController();
  TextEditingController relationshipToInsuredController =
      TextEditingController();
  FocusNode beneficiaryNameFocusNode = FocusNode();
  FocusNode relationshipToInsuredFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _submit(newInsuranceProvider, double insurancePrice) {
      final enteredData = {
        'insuranceType': newInsuranceProvider.insuranceData['insurance type'],
        'companyName': newInsuranceProvider.insuranceData['company'],
        'start date': newInsuranceProvider.date,
        'benefitPeriod': newInsuranceProvider.selectedBenifitPeriod,
        'incomeDetails': newInsuranceProvider.selectedincomeDetails,
        'employmentStatus': newInsuranceProvider.selectedEmploymentStatus,
        'jobTitle': _jobTitleController.text,
        'desiredCoverage': _desiredCoverageController.text,
        'medicalHistory': _medicalHistoryController.text,
        'smokingOrAlcohol': _smokingOrAlcoholController.text,
        'beneficiary': _beneficiaryController.text,
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
          builder: (context) => IncomePdfScreen(
            fieldData: enteredData,
          ),
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
    final benefitPeriodList = newInsuranceProvider.getBenifitPeriod();
    final incomeDetailsList = newInsuranceProvider.getIncomeDetails();
    final employmentStatusList = newInsuranceProvider.getEmploymentStatus();
    final thirdParty = newInsuranceProvider.getThridParty();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyTextField(
            focusNode: _jobTitleFocusNode,
            controller: _jobTitleController,
            icon: Icons.work,
            isPassword: false,
            text: 'Job Title',
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
            value: newInsuranceProvider.selectedEmploymentStatus,
            hint: Text('Employment Status'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedEmploymentStatus(value);
              }
            },
            items: employmentStatusList.map((status) {
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
            value: newInsuranceProvider.selectedincomeDetails,
            hint: Text('Income Details'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedIncomeDetails(value);
              }
            },
            items: incomeDetailsList.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _desiredCoverageFocusNode,
            controller: _desiredCoverageController,
            icon: Icons.person,
            isPassword: false,
            text: 'How much you willing to pay?',
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
            value: newInsuranceProvider.selectedBenifitPeriod,
            hint: Text('For how long you want it?'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedBenifitPeriod(value);
              }
            },
            items: benefitPeriodList.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _medicalHistoryFocusNode,
            controller: _medicalHistoryController,
            icon: Icons.medical_information,
            isPassword: false,
            text: 'Any Recent Illnesses or Surgeries?',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _smokingOrAlcoholFocusNode,
            controller: _smokingOrAlcoholController,
            icon: Icons.smoking_rooms,
            isPassword: false,
            text: 'Smoking or Alcohol Consumption',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _beneficiaryFocusNode,
            controller: _beneficiaryController,
            icon: Icons.person,
            isPassword: false,
            text: 'person to receive benefits in case of a claim',
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
