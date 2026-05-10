import 'package:flutter/material.dart';

class TextStylesManager {
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;

  static TextStyle getMediumStyle({
    double fontSize = s16,
    required Color color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle getRegularStyle({
    double fontSize = s14,
    required Color color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
}
