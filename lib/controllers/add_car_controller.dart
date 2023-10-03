import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants/utils.dart';
import '../db/database_helper.dart';
import '../screens/dashboard/dashboard_screen.dart';

class AddCarController extends GetxController {
  final controller = TextEditingController();
  DatabaseHelper? dbHelper;

  void checkValidation() async {
    if (controller.text.isEmpty) {
      Utils.redSnackbar("Error", "Please enter car number");
    } else {
      insertData();
    }
  }

  void insertData() async {
    final PermissionStatus status = await Permission.location.request();

    if (Platform.isAndroid) {
      if (status.isGranted) {
        try {
          final dbHelper = DatabaseHelper(); // Initialize the dbHelper instance
          await dbHelper.initializeDatabase();

          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
          );

          final carNumber = controller.text.trim().toString();
          final dateTime = createDateTime();
          final existingRecord = await dbHelper.getRecordByCarNumber(carNumber);

          if (existingRecord != null) {
            Utils.redSnackbar("Error", "Car is already parked");
            return null;
          }
          final rowsAffected = await dbHelper.insertParkingData(
            carNumber: carNumber,
            checkInTime: dateTime,
            checkOutTime: '',
            latitude: position.latitude,
            longitude: position.longitude,
          );

          debugPrint("rowsAffected : $rowsAffected");

          if (rowsAffected != -1) {
            Utils.greenSnackbar("Success", 'Car parked successfully');
            Get.to(() => const DashboardScreen());
          } else {
            Utils.redSnackbar("Error", "There is error parking car");
          }
        } catch (e) {
          print('Error inserting data: $e');
        }
      }
    }
  }

  static createDateTime() {
    final dateTime = DateTime.now();
    debugPrint("Date Time : $dateTime");
    final formatted = DateFormat('dd-MM-yyyy HH:mm aa');
    return formatted.format(dateTime);
  }
}
