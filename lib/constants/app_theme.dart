import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

class AppTheme {
  static themeData() {
    return ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontSize: 24,
                fontFamily: exoFont,
                color: black,
                fontWeight: FontWeight.w600),
            displayMedium: TextStyle(
                fontSize: 18,
                fontFamily: exoFont,
                color: greyText,
                fontWeight: FontWeight.w600),
            displaySmall: TextStyle(
                fontSize: 16,
                fontFamily: exoFont,
                color: greyText,
                fontWeight: FontWeight.w400),
            bodyLarge: TextStyle(
                fontSize: 18,
                fontFamily: exoFont,
                color: black,
                fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(
                fontSize: 16,
                fontFamily: exoFont,
                color: greyText,
                fontWeight: FontWeight.w400)),
        scaffoldBackgroundColor: white,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: 18,
              fontFamily: exoFont,
              color: white,
              fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(
            color: white
          ),
          backgroundColor: primaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: exoFont,
              color: greyText,
              fontWeight: FontWeight.w600),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: black, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: black, width: 1)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                backgroundColor: MaterialStateProperty.all(primaryColor),
                textStyle: MaterialStateProperty.all(const TextStyle(
                    fontSize: 16,
                    fontFamily: exoFont,
                    color: white,
                    fontWeight: FontWeight.w600)))));
  }
}
