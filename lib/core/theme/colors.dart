import 'package:flutter/material.dart';

class ColorsManager {
  static const Color primary = Colors.blue;
  static const Color blueAccent = Colors.blueAccent;
  static const Color indigo = Colors.indigo;
  static const Color error = Colors.red;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color grey = Colors.grey;

  static Color getBlurOverlayColor(bool isDark) {
    return isDark
        ? black.withValues(alpha: 0.3)
        : black.withValues(alpha: 0.15);
  }

  static Color getMenuBackgroundColor(bool isDark) {
    return isDark ? black.withValues(alpha: 0.7) : white.withValues(alpha: 0.7);
  }

  static Color getDividerColor(bool isDark) {
    return isDark ? white.withValues(alpha: 0.1) : black.withValues(alpha: 0.1);
  }

  static Color getContentColor(bool isDark) {
    return isDark ? white : black;
  }
}
