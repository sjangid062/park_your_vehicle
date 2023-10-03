import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:park_your_vehicle/controllers/add_car_controller.dart';
import 'package:park_your_vehicle/widgets/button_widget.dart';
import 'package:park_your_vehicle/widgets/image_widget.dart';
import 'package:park_your_vehicle/widgets/text_field_widget.dart';

import '../../constants/images.dart';
import '../../constants/padding.dart';
import '../../constants/strings.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {

  @override
  Widget build(BuildContext context) {
    final addCarController = Get.put(AddCarController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(addYourVehicle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: defaultPadding,
          child: Column(
            children: [
              const ImageWidget(imagePath: appLogo),
              const SizedBox(height: 10),
              EditTextWidget(
                  controller: addCarController.controller,
                  hintText: enterVehicleNumber),
              const SizedBox(height: 40),
              ButtonWidget(title: addVehicle, onPressed: () {
                addCarController.checkValidation();
              })
            ],
          ),
        ),
      ),
    );
  }
}
