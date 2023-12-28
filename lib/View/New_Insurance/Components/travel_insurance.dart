import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/Util/colors.dart';
import 'package:insurance_app/View/Insurance_details/travel_pdf_screen.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/Model/companies_model.dart';

class TravelInsurance extends StatefulWidget {
  TravelInsurance({
    super.key,
  });

  @override
  State<TravelInsurance> createState() => _TravelInsuranceState();
}

class _TravelInsuranceState extends State<TravelInsurance> {
  var policyNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyNumber = Provider.of<InsuranceProvider>(context, listen: false)
        .generateRandomInsuranceNumber();
  }

  FocusNode _passportNumberFocusNode = FocusNode();
  FocusNode _placeOfBirthFocusNode = FocusNode();

  TextEditingController _passportNumberController = TextEditingController();
  TextEditingController _placeOfBirthController = TextEditingController();

  TextEditingController beneficiaryNameController = TextEditingController();
  TextEditingController relationshipToInsuredController =
      TextEditingController();
  FocusNode beneficiaryNameFocusNode = FocusNode();
  FocusNode relationshipToInsuredFocusNode = FocusNode();

  void _submitForm(insuranceProvider, double insurancePrice) {
    final enteredData = {
      'insuranceType': insuranceProvider.insuranceData['insurance type'],
      'companyName': insuranceProvider.insuranceData['company'],
      'PassportNumber': _passportNumberController.text,
      'PlaceOfBirth': _placeOfBirthController.text,
      'personAge': insuranceProvider.selectedPersonAge,
      'PeriodCoverage': insuranceProvider.selectedPeriodOfCoverage,
      'IndividualOrFamily': insuranceProvider.selectedIndividualOrFamily,
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
        builder: (context) => TravelPdfScreen(fieldData: enteredData),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  // add صورة من كتيب السيارة and engin power
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
    final personAgeList = newInsuranceProvider.getPersonAge();
    final PeriodCoverageList = newInsuranceProvider.getPeriodOfCoverage();
    final IndividualOrFamilyList = newInsuranceProvider.getIndividualOrFamily();
    final thirdParty = newInsuranceProvider.getThridParty();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyTextField(
            focusNode: _passportNumberFocusNode,
            controller: _passportNumberController,
            icon: Icons.document_scanner_outlined,
            isPassword: false,
            text: 'Passport Number',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          MyTextField(
            focusNode: _placeOfBirthFocusNode,
            controller: _placeOfBirthController,
            icon: Icons.pin_drop_outlined,
            isPassword: false,
            text: 'Location of Birth',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Select Departure date',
                style: GoogleFonts.arapey(
                  fontSize: size.width * 0.06,
                ),
              ),
              Container(
                width: size.width * 0.3,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  color: SharedColor.lightBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () {
                    context
                        .read<NewInsuranceProviderButtonFunctions>()
                        .selectTravelDate(context);
                  },
                  child: Consumer<NewInsuranceProviderButtonFunctions>(
                    builder: (context, dataClass, child) {
                      return Text('${dataClass.selectedTravelDate.toLocal()}'
                          .split(' ')[0]);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            value: newInsuranceProvider.selectedPeriodOfCoverage,
            hint: Text('Period of coverage'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedCoverageAge(value);
              }
            },
            items: PeriodCoverageList.map((status) {
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
            value: newInsuranceProvider.selectedPersonAge,
            hint: Text('Person Age'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedPersonAge(value);
              }
            },
            items: personAgeList.map((status) {
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
            value: newInsuranceProvider.selectedIndividualOrFamily,
            hint: Text('Individual/Family'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedIndividualOrFamily(value);
              }
            },
            items: IndividualOrFamilyList.map((status) {
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
