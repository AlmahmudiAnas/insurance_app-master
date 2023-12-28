import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/provider.dart';
import '../Screens/accepted_claims.dart';
import '../Screens/business_insurance.dart';
import '../Screens/car_insurance.dart';
import '../Screens/claim_submissions.dart';
import '../Screens/flood_insurance.dart';
import '../Screens/health_insurance.dart';
import '../Screens/income_insurance.dart';
import '../Screens/life_insurance.dart';
import '../Screens/property_insurance.dart';
import '../Screens/rejected_claim.dart';
import '../Screens/statistics_screen.dart';
import '../Screens/travel_insurance.dart';

class Sidebar extends StatefulWidget {
  final Size size;

  const Sidebar({Key? key, required this.size}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width / 3.7,
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Image.asset(
                'images/insurancelogo.png',
                height: 60,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Tameen',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(),
          Consumer<DashboardProvider>(
            builder: (context, provider, _) {
              if (provider.companyName == 'Company 1')
                return CompanyOne();
              else if (provider.companyName == 'Company 2')
                return CompanyTwo();
              else if (provider.companyName == 'Alwatheka')
                return AlWathekaInsurances();
              else if (provider.companyName == 'Qafela')
                return QafelaInsurance();
              else
                return SizedBox.shrink();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text('Statistics'),
            onTap: () {
              // Handle navigation to the statistics page here
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(StatisticsScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Claims Submissions'),
            onTap: () {
              // Handle navigation to the claims submissions page here
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(ClaimSubmissionsDB());
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Accepted Claims Submissions'),
            onTap: () {
              // Handle navigation to the claims submissions page here
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(AcceptedClaimSubmissionsDB());
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Rejected Claims Submissions'),
            onTap: () {
              // Handle navigation to the claims submissions page here
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(RejectedClaimSubmissionsDB());
            },
          ),
          // Add more items as needed
        ],
      ),
    );
  }
}

class CompanyOne extends StatefulWidget {
  const CompanyOne({
    super.key,
  });

  @override
  State<CompanyOne> createState() => _CompanyOneState();
}

class _CompanyOneState extends State<CompanyOne> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Health Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(HealthInsuraceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Car Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(CarInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Life Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(LifeInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Property Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(PropertyInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Income protection Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(IncomeProtectionInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CompanyTwo extends StatefulWidget {
  const CompanyTwo({
    super.key,
  });

  @override
  State<CompanyTwo> createState() => _CompanyTwoState();
}

class _CompanyTwoState extends State<CompanyTwo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Health Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(HealthInsuraceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Car Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(CarInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Life Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(LifeInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Property Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(PropertyInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Travel Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(TravelInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Flood Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(FloodInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AlWathekaInsurances extends StatefulWidget {
  const AlWathekaInsurances({
    super.key,
  });

  @override
  State<AlWathekaInsurances> createState() => _AlWathekaInsurancesState();
}

class _AlWathekaInsurancesState extends State<AlWathekaInsurances> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Health Insurance'),
            onTap: () {
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(HealthInsuraceDB());
              // Handle navigation to the home screen here
              // For example, you can use Navigator.push() to navigate to the home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Car Insurance'),
            onTap: () {
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(CarInsuranceDB());
              // Handle navigation to the home screen here
              // For example, you can use Navigator.push() to navigate to the home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Life Insurance'),
            onTap: () {
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(LifeInsuranceDB());
              // Handle navigation to the home screen here
              // For example, you can use Navigator.push() to navigate to the home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Property Insurance'),
            onTap: () {
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(PropertyInsuranceDB());
              // Handle navigation to the home screen here
              // For example, you can use Navigator.push() to navigate to the home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Travel Insurance'),
            onTap: () {
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(TravelInsuranceDB());
              // Handle navigation to the home screen here
              // For example, you can use Navigator.push() to navigate to the home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Flood Insurance'),
            onTap: () {
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(FloodInsuranceDB());
              // Handle navigation to the home screen here
              // For example, you can use Navigator.push() to navigate to the home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Business interruption Insurance'),
            onTap: () {
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(BusinessInsuranceDB());
              // Handle navigation to the home screen here
              // For example, you can use Navigator.push() to navigate to the home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Income protection Insurance'),
            onTap: () {
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen(IncomeProtectionInsuranceDB());
              // Handle navigation to the home screen here
              // For example, you can use Navigator.push() to navigate to the home screen
            },
          ),
        ],
      ),
    );
  }
}

class QafelaInsurance extends StatefulWidget {
  const QafelaInsurance({
    super.key,
  });

  @override
  State<QafelaInsurance> createState() => _QafelaInsuranceState();
}

class _QafelaInsuranceState extends State<QafelaInsurance> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Health Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(HealthInsuraceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Car Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(CarInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Life Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(LifeInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Property Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(PropertyInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Travel Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(TravelInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Business interruption Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(BusinessInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Income protection Insurance'),
              onTap: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .changeScreen(IncomeProtectionInsuranceDB());
                // Handle navigation to the home screen here
                // For example, you can use Navigator.push() to navigate to the home screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
