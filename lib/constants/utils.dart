import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'colors.dart';

class Utils {
  static redSnackbar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.redAccent, colorText: white);
  }

  static greenSnackbar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.green, colorText: white);
  }

  static createDateTime() {
    final dateTime = DateTime.now();
    debugPrint("Date Time : $dateTime");
    final formatted = DateFormat('dd-MM-yyyy HH:mm aa');
    return formatted.format(dateTime);
  }
}
