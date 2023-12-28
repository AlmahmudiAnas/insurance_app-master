import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Insurance Types Chart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: size.height,
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Companies')
                    .doc(getCurrentUserId())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    var userCompany = snapshot.data?['company name'];
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Insurances')
                          .where('company name', isEqualTo: userCompany)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          final data = snapshot.data!.docs;

                          // Create a Map to store the count of each insurance type
                          Map<String, int> insuranceCount = {};
                          data.forEach((document) {
                            final insuranceType =
                                document['Insurance Type'] as String;

                            // If the insurance type exists in the map, increment the count
                            // Otherwise, create a new entry in the map with count 1
                            insuranceCount.update(
                                insuranceType, (value) => value + 1,
                                ifAbsent: () => 1);
                          });

                          // Convert the Map to a List of data points for the chart
                          List<ChartData> chartData = insuranceCount.entries
                              .map((entry) =>
                                  ChartData(entry.key, entry.value.toDouble()))
                              .toList();

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SfCircularChart(
                                  series: <CircularSeries>[
                                    DoughnutSeries<ChartData, String>(
                                      dataSource: chartData,
                                      xValueMapper: (data, _) => data.label,
                                      yValueMapper: (data, _) => data.value,
                                      dataLabelSettings: DataLabelSettings(
                                          isVisible:
                                              true), // Disable data labels
                                    ),
                                  ],
                                  tooltipBehavior: TooltipBehavior(
                                    // Add the tooltip behavior
                                    enable: true, // Enable tooltip on hover
                                    header:
                                        '', // Customize the tooltip header if needed
                                    format:
                                        'point.x: point.y%', // Customize the tooltip content to show label and value
                                  ),
                                  legend: Legend(
                                    // Add the legend
                                    isVisible: true,
                                    position: LegendPosition
                                        .bottom, // Position the legend at the bottom
                                    overflowMode: LegendItemOverflowMode
                                        .wrap, // Wrap the legend items if needed
                                  ),
                                ),
                                SizedBox(height: 30),
                                Text(
                                  'Number of Users by Insurance Type (All Time)',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 300,
                                  child: StreamBuilder<List<ChartData>>(
                                    stream: _getInsuranceUserData(userCompany),
                                    builder: (context, dataSnapshot) {
                                      if (dataSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (dataSnapshot.hasData) {
                                        final chartData = dataSnapshot.data!;

                                        return SfCartesianChart(
                                          primaryXAxis: CategoryAxis(),
                                          series: <ChartSeries>[
                                            ColumnSeries<ChartData, String>(
                                              dataSource: chartData,
                                              xValueMapper: (data, _) =>
                                                  data.label,
                                              yValueMapper: (data, _) =>
                                                  data.value,
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                      isVisible: true),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Center(
                                            child: Text('No data available'));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: Text('No data available'));
                        }
                      },
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Text('Error retrieving data'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<ChartData>> _getInsuranceUserData(String userCompany) {
    // Sample data format: [{"Insurance Type": "Type A", "User Count": 100}, {"Insurance Type": "Type B", "User Count": 150}, ...]
    List<Map<String, dynamic>> insuranceUserData = [];

    insuranceUserData = [
      {"Insurance Type": "Health", "User Count": 5},
      {"Insurance Type": "Car", "User Count": 10},
      {"Insurance Type": "Life", "User Count": 7},
      {"Insurance Type": "Property", "User Count": 15},
    ];
    // Convert the insuranceUserData to a List of ChartData objects
    return Stream.value(insuranceUserData.map((data) {
      final insuranceType = data['Insurance Type'] as String;
      final userCount = data['User Count'] as int;
      return ChartData(insuranceType, userCount.toDouble());
    }).toList());
  }
}

class ChartData {
  final String label;
  final double value;

  ChartData(this.label, this.value);
}
