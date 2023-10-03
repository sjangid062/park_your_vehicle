import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

import '../constants/check_connectivity.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadDataToFirebase(List<Map<String, dynamic>>? data) async {
    final isNetworkAvailable = await Connectivity().checkConnectivity() != ConnectivityResult.none;

    if (!isNetworkAvailable) {
      // Handle no network connection, such as queuing data for later upload.
      print('No network connection. Data upload postponed.');
      return;
    }

    final collectionReference = FirebaseFirestore.instance.collection('carparking');

    for (final item in data ?? []) {
      try {
        // Upload data to Firebase Firestore
        await collectionReference.add({
          'carNumber': item['carNumber'],
          'checkInTime': item['checkInTime'],
          'checkOutTime': item['checkOutTime'],
          'latitude': item['latitude'],
          'longitude': item['longitude'],
        });

        // If the upload is successful, you can mark the item as synced in your local database
        // using your DatabaseHelper class.
        // DatabaseHelper().markItemAsSynced(item.id);
        print('Data uploaded successfully: ${item['carNumber']}');
      } catch (e) {
        // Handle upload errors, e.g., show an error message or retry later
        print('Error uploading data: $e');
      }
    }
  }


}