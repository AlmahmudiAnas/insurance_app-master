import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Model/companies_model.dart';
import 'package:insurance_app/Util/My_Widget/my_drawer.dart';
import 'package:insurance_app/Util/colors.dart';
import 'package:insurance_app/View/New_Insurance/Components/business_insurance.dart';
import 'package:insurance_app/View/New_Insurance/Components/car_insurance.dart';
import 'package:insurance_app/View/New_Insurance/Components/flood_insurance.dart';
import 'package:insurance_app/View/New_Insurance/Components/health_insurance.dart';
import 'package:insurance_app/View/New_Insurance/Components/home_insurance.dart';
import 'package:insurance_app/View/New_Insurance/Components/income_insurance.dart';
import 'package:insurance_app/View/New_Insurance/Components/life_insurance.dart';
import 'package:insurance_app/View/New_Insurance/Components/travel_insurance.dart';
import 'package:insurance_app/View_Model/new_insurance_provider_buttons_function.dart';
import 'package:provider/provider.dart';

class NewInsurance extends StatefulWidget {
  const NewInsurance({super.key});
  static String routeName = 'New Insurance';

  @override
  State<NewInsurance> createState() => _NewInsuranceState();
}

class _NewInsuranceState extends State<NewInsurance> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newInsuranceProvider =
        Provider.of<NewInsuranceProviderButtonFunctions>(context);
    final insuranceList = newInsuranceProvider.getInsuranceType();

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: MyDrawer(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 167, 201, 87),
          elevation: 0,
          title: Center(
            child: Text(
              'New Insurance',
              style: GoogleFonts.acme(color: Colors.black),
            ),
          ),
          flexibleSpace: Container(
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 167, 201, 87),
                  Color.fromARGB(255, 239, 239, 239),
                ],
                stops: [0.1, 0.9],
              ),
            ),
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 167, 201, 87),
                    Color.fromARGB(255, 239, 239, 239),
                  ],
                  stops: [0.1, 0.9],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                width: size.width / 1.15,
                height: size.height / 1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Insurace Type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      DropdownButtonFormField<InsuranceType>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        value: newInsuranceProvider.selectedInsuranceType,
                        hint: Text('Choose an Insurance Type'),
                        onChanged: (InsuranceType? newValue) {
                          if (newValue != null) {
                            newInsuranceProvider
                                .setSelectedInsuranceType(newValue);
                          }
                        },
                        items: insuranceList.map((insuranceType) {
                          return DropdownMenuItem(
                            value: insuranceType,
                            child: Text(insuranceType.name),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        "Company",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButtonFormField<Company>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        value: newInsuranceProvider.selectedCompany,
                        hint: Text('Choose a Company'),
                        onChanged: (Company? newValue) {
                          if (newValue != null) {
                            newInsuranceProvider.setSelectedCompany(newValue);
                          }
                        },
                        items: newInsuranceProvider
                            .getCompaniesForInsuranceType()
                            .map((company) {
                          return DropdownMenuItem(
                            value: company,
                            child: Text(company.companyName),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Select start date',
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
                                    .selectDate(context);
                              },
                              child:
                                  Consumer<NewInsuranceProviderButtonFunctions>(
                                builder: (context, dataClass, child) {
                                  return Text(
                                      '${dataClass.selectedDate.toLocal()}'
                                          .split(' ')[0]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Price: \$${newInsuranceProvider.selectedCompany?.price.toStringAsFixed(2) ?? '0.00'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (newInsuranceProvider.selectedInsuranceType?.name ==
                          'Health Insurance')
                        HealthInsurance(),
                      if (newInsuranceProvider.selectedInsuranceType?.name ==
                          'Car Insurance')
                        CarInsurance(),
                      if (newInsuranceProvider.selectedInsuranceType?.name ==
                          'Life Insurance')
                        LifeInsurance(),
                      if (newInsuranceProvider.selectedInsuranceType?.name ==
                          'Property Insurance')
                        HomeInsurance(),
                      if (newInsuranceProvider.selectedInsuranceType?.name ==
                          'Travel Insurance')
                        TravelInsurance(),
                      if (newInsuranceProvider.selectedInsuranceType?.name ==
                          'Flood Insurance')
                        FloodInsurance(),
                      if (newInsuranceProvider.selectedInsuranceType?.name ==
                          'Business interruption Insurance')
                        BusinessInsurance(),
                      if (newInsuranceProvider.selectedInsuranceType?.name ==
                          'Income protection Insurance')
                        IncomeInsurance(),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
