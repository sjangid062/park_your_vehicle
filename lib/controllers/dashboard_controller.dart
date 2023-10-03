
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../db/database_helper.dart';

class DashboardController extends GetxController {

  Future<List<Map<String, dynamic>>?> getAllCarsAndDisplay() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.initializeDatabase();
    final carRecords = await dbHelper.getAllCars();
    debugPrint("carRecords : $carRecords");
    return carRecords;
  }

  Future<void> launchGoogleMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if(Platform.isAndroid) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch Google Maps.';
      }
    }
  }

}