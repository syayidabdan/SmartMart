import 'package:flutter/material.dart';
import 'package:ui_ecommerce/constant.dart';

ThemeData themeData() {
  return ThemeData(
    fontFamily: "Muli",
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: kTextColor,
          fontSize: 18,
        )),
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: inputDecorationTheme(),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    titleMedium: TextStyle(color: kTextColor),
    bodyMedium: TextStyle(color: kTextColor),
  );
}

InputDecorationTheme inputDecorationTheme() {
  var outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(28),
    ),
    borderSide: BorderSide(
      color: kPrimaryColor,
    ),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 42,
      vertical: 20,
    ),
    labelStyle: const TextStyle(
      color: kPrimaryColor,
    ),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
