import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future<void> initializeDatabase() async {
    final path = await getDatabasesPath();
    debugPrint("DB Path : $path");
    final databasePath = join(path, 'carparking.db');
    _database = await openDatabase(
      databasePath,
      version: 2,
      onCreate: (db, version) {
        db.execute(
          '''
          CREATE TABLE carparking (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            carNumber TEXT,
            checkInTime TEXT,
            checkOutTime TEXT,
            latitude REAL,
            longitude REAL
          )
          ''',
        );
      },
    );
  }

  Future<int?> insertParkingData({
    required String carNumber,
    required String checkInTime,
    required String checkOutTime,
    required double latitude,
    required double longitude
  }) async {
    final data = {
      'carNumber': carNumber,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'latitude': latitude,
      'longitude': longitude
    };
    return await _database?.insert('carparking', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>?> getAllCars() async {
    final db = await _database;
    return await db?.query('carparking');
  }

  Future<void> updateCheckoutTimeForCar(
      String carNumber, String newCheckoutTime, double latitude, double longitude) async {
    final db = await _database;

    await db?.update(
      'carparking',
      {
        'checkOutTime': newCheckoutTime,
        'latitude': latitude,
        'longitude': longitude,
      },
      where: 'carNumber = ?',
      whereArgs: [carNumber],
    );
  }

  Future<List<Map<String, dynamic>>?> queryData() async {
    final db = await _database;
    return await db?.query('carparking'); // Replace 'your_table_name' with your actual table name
  }

  // Helper method to retrieve a record by car number
  Future<Map<String, dynamic>?> getRecordByCarNumber(String carNumber) async {
    final List<Map<String, dynamic>> records =
        (await _database?.query(
          'carparking',
          where: 'carNumber = ?',
          whereArgs: [carNumber],
        ))?.map((e) => e).toList() ?? [];

    if (records.isNotEmpty) {
      return records.first;
    }

    return null;
  }
}
