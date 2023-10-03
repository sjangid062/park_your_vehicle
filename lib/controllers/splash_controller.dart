import 'package:get/get.dart';
import 'package:park_your_vehicle/screens/dashboard/add_car_screen.dart';

class SplashController extends GetxController {

  void goToMainScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const AddCarScreen());
    });
  }
}