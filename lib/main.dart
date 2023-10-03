import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:park_your_vehicle/screens/splash_screen/splash_screen.dart';

import 'constants/app_theme.dart';
import 'db/database_helper.dart';
import 'firebase/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyA0IaWAiAYOtcrEdLHpN6xmuxNE0ie-gAc',
          appId: '1:597557028301:android:a2111d178d94ce372d9084',
          messagingSenderId: '597557028301',
          projectId: 'park-your-vehicle-2e79e')
    );
  }
  final dbHelper = DatabaseHelper();
  await dbHelper.initializeDatabase();
  final localData = await getDataFromLocalStorage(); // Step 1
  final isConnected = await isInternetConnected(); // Step 2

  debugPrint(localData.toString());
  if (isConnected) {
    await FirebaseService().uploadDataToFirebase(localData); // Step 3
  }
  runApp(const MyApp());
}

Future<List<Map<String, dynamic>>?> getDataFromLocalStorage() async {
  final dbHelper = DatabaseHelper();
  await dbHelper.initializeDatabase();
  return dbHelper.queryData(); // Implement this method to retrieve data from local storage
}

// Step 2: Check for Internet Connectivity
Future<bool> isInternetConnected() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
}

// Step 3: Upload Data to Firestore
void uploadDataToFirestore(List<Map<String, dynamic>> data) async {
  final firebaseService = FirebaseService(); // Initialize your Firebase service class
  await firebaseService.uploadDataToFirebase(data);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      home: const SplashScreen(),
    );
  }
}

