import 'package:connectivity/connectivity.dart';

class ConnectivityChecker {
  // Singleton instance
  static final ConnectivityChecker _instance = ConnectivityChecker._internal();

  factory ConnectivityChecker() {
    return _instance;
  }

  ConnectivityChecker._internal();

  Future<bool> isNetworkAvailable() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
