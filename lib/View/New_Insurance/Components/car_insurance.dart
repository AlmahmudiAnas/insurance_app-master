import 'package:flutter/material.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/Util/My_Widget/my_text_field.dart';
import 'package:insurance_app/View/Insurance_details/car_pdf_screen.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/Model/companies_model.dart';

class CarInsurance extends StatefulWidget {
  CarInsurance({
    super.key,
  });

  @override
  State<CarInsurance> createState() => _CarInsuranceState();
}

class _CarInsuranceState extends State<CarInsurance> {
  var policyNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyNumber = Provider.of<InsuranceProvider>(context, listen: false)
        .generateRandomInsuranceNumber();
  }

  final FocusNode chassisFocusNode = FocusNode();

  final FocusNode carOwnerFocusNode = FocusNode();

  final FocusNode addressFocusNode = FocusNode();

  final FocusNode carTypeFocusNode = FocusNode();

  final FocusNode enginePowerFocusNode = FocusNode();

  final FocusNode yearMadeFocusNode = FocusNode();
  final FocusNode plateNumberFocusNode = FocusNode();
  final FocusNode usedForFocusNode = FocusNode();
  final FocusNode motorNumberFocusNode = FocusNode();

  final TextEditingController _chassisNumberController =
      TextEditingController();

  final TextEditingController _carOwnerController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _carTypeController = TextEditingController();

  final TextEditingController _enginePowerController = TextEditingController();

  final TextEditingController _yearMadeController = TextEditingController();
  final TextEditingController _plateNumberController = TextEditingController();
  final TextEditingController _usedForController = TextEditingController();
  final TextEditingController _motorNumberController = TextEditingController();

  TextEditingController beneficiaryNameController = TextEditingController();
  TextEditingController relationshipToInsuredController =
      TextEditingController();
  FocusNode beneficiaryNameFocusNode = FocusNode();
  FocusNode relationshipToInsuredFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  void _submitForm(insuranceProvider, double insurancePrice) {
    final enteredData = {
      'insuranceType': insuranceProvider.insuranceData['insurance type'],
      'companyName': insuranceProvider.insuranceData['company'],
      'carType': _carTypeController.text,
      'carOwner': _carOwnerController.text,
      'address': _addressController.text,
      'chassisNumber': _chassisNumberController.text,
      'plateNumber': _plateNumberController.text,
      'enginePower': _enginePowerController.text,
      'motorNumber': _motorNumberController.text,
      'usedFor': _usedForController.text,
      'yearMade': _yearMadeController.text,
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
        builder: (context) => carPdfScreen(fieldData: enteredData),
      ),
    );
  }

  // add صورة من كتيب السيارة and engin power
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
    final carInsuranceTimeList = newInsuranceProvider.getCarInsuranceTime();
    final thirdParty = newInsuranceProvider.getThridParty();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyTextField(
            focusNode: carTypeFocusNode,
            controller: _carTypeController,
            icon: Icons.car_rental,
            isPassword: false,
            text: 'Car Model',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: carOwnerFocusNode,
            controller: _carOwnerController,
            icon: Icons.family_restroom,
            isPassword: false,
            text: 'Owner Name',
            textInputType: TextInputType.text,
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
            focusNode: chassisFocusNode,
            controller: _chassisNumberController,
            icon: Icons.car_rental,
            isPassword: false,
            text: 'Chassis Number',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: yearMadeFocusNode,
            controller: _yearMadeController,
            icon: Icons.date_range,
            isPassword: false,
            text: 'Year Car Made',
            textInputType: TextInputType.number,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: plateNumberFocusNode,
            controller: _plateNumberController,
            icon: Icons.car_rental,
            isPassword: false,
            text: 'Plate Number',
            textInputType: TextInputType.number,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: enginePowerFocusNode,
            controller: _enginePowerController,
            icon: Icons.engineering,
            isPassword: false,
            text: 'Egine Power',
            textInputType: TextInputType.number,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: motorNumberFocusNode,
            controller: _motorNumberController,
            icon: Icons.car_repair,
            isPassword: false,
            text: 'Motor Number',
            textInputType: TextInputType.text,
            validator: (value) {
              return newInsuranceProvider.validateEmpty(value.toString());
            },
          ),
          SizedBox(height: size.height * 0.01),
          MyTextField(
            focusNode: usedForFocusNode,
            controller: _usedForController,
            icon: Icons.car_crash,
            isPassword: false,
            text: 'Car is Used for',
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
            value: newInsuranceProvider.selectedCarInsuranceTime,
            hint: Text('Choose Insurance time'),
            onChanged: (value) {
              if (value != null) {
                newInsuranceProvider.setSelectedCarInsuranceTime(value);
                newInsuranceProvider.calculateCarTimePrice();
              }
            },
            items: carInsuranceTimeList.map((status) {
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
