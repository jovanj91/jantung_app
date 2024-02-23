// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../values/constant.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: colors(),
  );
}

ColorScheme colors() {
  return ColorScheme(
      brightness: Brightness.light,
      primary: kPrimaryColor,
      onPrimary: kOnPrimaryColor,
      secondary: kOnSecondaryColor,
      onSecondary: kOnSecondaryColor,
      error: kErrorColor,
      onError: kOnErrorColor,
      background: kBackgroundColor,
      onBackground: kOnBackgroundColor,
      surface: kSurfaceColor,
      onSurface: kOnSurfaceColor);
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: Colors.black),
      gapPadding: 10);
  return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder);
}

TextTheme textTheme() {
  return TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black));
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(color: Color(0xFF8D8D8D), fontSize: 15),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light);
}
