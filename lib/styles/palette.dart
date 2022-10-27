import 'package:flutter/material.dart';

class AppColor {
  static const Color white = Colors.white;
  static const Color darkGrey = Colors.black26;
  static const Color black = Colors.black;

  static const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
    50: Color(0xFFE1F9F2),
    100: Color(0xFFB5EFDD),
    200: Color(0xFF84E4C7),
    300: Color(0xFF52D9B1),
    400: Color(0xFF2DD1A0),
    500: Color(_primaryPrimaryValue),
    600: Color(0xFF07C387),
    700: Color(0xFF06BC7C),
    800: Color(0xFF04B572),
    900: Color(0xFF02A960),
  });
  static const int _primaryPrimaryValue = 0xFF08C98F;

  static const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFFD3FFE9),
    200: Color(_primaryAccentValue),
    400: Color(0xFF6DFFB7),
    700: Color(0xFF53FFAA),
  });
  static const int _primaryAccentValue = 0xFFA0FFD0;
}
