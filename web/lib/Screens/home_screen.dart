import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Drawer/drawer.dart';
import '../Provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = 'DashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DashboardProvider>(context, listen: false)
        .fetchUserCompanyName();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Center(
          child: Text('HomeScreen'),
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
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sidebar
            Container(
              child: SingleChildScrollView(child: Sidebar(size: size)),
            ),
            // Main Content
            Expanded(
              child: Center(
                child: Stack(
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
                    context.watch<DashboardProvider>().currentScreen,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeMessege extends StatelessWidget {
  const WelcomeMessege({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(''),
    );
  }
}
