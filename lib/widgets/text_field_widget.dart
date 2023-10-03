import 'package:flutter/material.dart';
import '../constants/colors.dart';

class EditTextWidget extends StatelessWidget {
  const EditTextWidget({super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: black,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText
      ),
    );
  }
}
