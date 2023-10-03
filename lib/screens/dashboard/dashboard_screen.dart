import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_your_vehicle/constants/images.dart';
import 'package:park_your_vehicle/constants/padding.dart';
import 'package:park_your_vehicle/controllers/dashboard_controller.dart';
import 'package:park_your_vehicle/db/database_helper.dart';
import 'package:park_your_vehicle/widgets/button_widget.dart';
import 'package:park_your_vehicle/widgets/image_widget.dart';
import 'package:park_your_vehicle/widgets/text_widget.dart';

import '../../constants/colors.dart';
import '../../constants/utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardController = Get.put(DashboardController());
  List<int> hiddenButtonIndices = [];
  @override
  void initState() {
    super.initState();
    dashboardController.getAllCarsAndDisplay();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Parking List"),
      ),
      body: Padding(
          padding: defaultPadding,
          child: FutureBuilder<List<Map<String, dynamic>>?>(
              future: dashboardController.getAllCarsAndDisplay(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Handle any errors that occurred during data retrieval.
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data != null && snapshot.hasData) {
                  final data = snapshot.data;
                  return ListView.separated(
                    clipBehavior: Clip.none,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final carData = data?[index];
                      List<bool> isCheckedOutList = List.generate(snapshot.data!.length, (_) => true);
                      final isCheckedOut = isCheckedOutList[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: greyText, width: 1)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ImageWidget(
                                imagePath: appLogo, width: 50, height: 50),
                            const SizedBox(width: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BuildBodyLargeText(
                                        title: carData?['carNumber'] ?? ""),
                                    BuildBodyMediumText(
                                        title: carData?['checkOutTime'] == '' ? "Checked-In" : "Checked-Out"),
                                    BuildBodyMediumText(
                                        title: carData?['checkInTime'] ?? ""),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                child: Container(
                                                  height: 180,
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: white),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const BuildBodyLargeText(
                                                              title:
                                                                  "latitude :"),
                                                          const SizedBox(
                                                              width: 10),
                                                          BuildBodyMediumText(
                                                              title: carData?[
                                                                          'latitude']
                                                                      .toString() ??
                                                                  ""),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        children: [
                                                          const BuildBodyLargeText(
                                                              title:
                                                                  "longitude :"),
                                                          const SizedBox(
                                                              width: 10),
                                                          BuildBodyMediumText(
                                                              title: carData?[
                                                                          'longitude']
                                                                      .toString() ??
                                                                  ""),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 20),
                                                      ButtonWidget(
                                                          title: "See Location",
                                                          onPressed: () {
                                                            dashboardController
                                                                .launchGoogleMaps(
                                                                    carData?[
                                                                        'latitude'],
                                                                    carData?[
                                                                        'longitude']);
                                                          })
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.location_on)),
                                    Visibility(
                                      visible: carData?['checkOutTime'] == '',
                                      child: IconButton(
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const BuildBodyLargeText(title: "Alert"),
                                                  content: const BuildBodyMediumText(title: "Are you sure you want to check-out ?"),
                                                  actions: [
                                                    TextButton(onPressed: () {
                                                        Get.back();
                                                    }, child: const BuildBodyMediumText(title: "No")),
                                                    TextButton(
                                                      onPressed: () async {
                                                        final dbHelper = DatabaseHelper(); // Initialize the dbHelper instance
                                                        await dbHelper.initializeDatabase();

                                                        // Update the database first
                                                        await dbHelper.updateCheckoutTimeForCar(
                                                          carData?['carNumber'] ?? "",
                                                          Utils.createDateTime(),
                                                          carData?['latitude'],
                                                          carData?['longitude'],
                                                        );

                                                        // Navigate back
                                                        Get.back();

                                                        // Trigger a refresh of the UI if needed
                                                        setState(() {
                                                        });
                                                      },
                                                      child: const BuildBodyMediumText(title: "Yes"),
                                                    )
                                                  ],
                                                );
                                              },
                                            );

                                          },
                                          icon: const Icon(Icons.logout)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                  );
                } else {
                  return const Center(child: Text('No data available.'));
                }
              })),
    );
  }
}
