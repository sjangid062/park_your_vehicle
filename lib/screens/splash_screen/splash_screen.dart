import 'package:flutter/material.dart';
import 'package:park_your_vehicle/controllers/splash_controller.dart';
import 'package:park_your_vehicle/widgets/image_widget.dart';

import '../../constants/images.dart';
import '../../constants/strings.dart';
import '../../widgets/text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = SplashController();

  @override
  void initState() {
    super.initState();
    splashController.goToMainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(imagePath: appLogo, width: 120, height: 120),
            SizedBox(height: 10),
            BuildDisplayLargeText(title: appName),
          ],
        ),
      ),
    );
  }
}
