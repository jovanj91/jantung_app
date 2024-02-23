import 'package:flutter/material.dart';
import '../utils/size_config.dart';

const kPrimaryColor = Color.fromARGB(255, 97, 130, 100);
const kPrimaryLightColor = Color.fromARGB(255, 121, 172, 120);
const kOnPrimaryColor = Colors.white;
// const kPrimaryGradientColor = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [Color(0xFFFFA53E), Color(0xFFFF7643)]);
const kSecondaryColor = Color.fromARGB(255, 121, 127, 129);
const kSecondaryLightColor = Color.fromARGB(255, 176, 217, 177);
const kOnSecondaryColor = Colors.black;
const kBackgroundColor = Colors.white;
const kOnBackgroundColor = Colors.black;
const kErrorColor = Colors.red;
const kOnErrorColor = Colors.white;
const kSurfaceColor = Colors.white;
const kOnSurfaceColor = Colors.black;
const kActivateWidget = kPrimaryColor;
const kInacvtiveWidget = Colors.grey;

const kAnimationDration = Duration(milliseconds: 200);
final headingStyle = TextStyle(
    fontSize: getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5);
