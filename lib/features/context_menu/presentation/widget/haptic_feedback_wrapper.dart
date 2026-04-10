import 'package:flutter/services.dart';

class HapticFeedbackHelper {
  static Future<void> triggerMedium() async {
    await HapticFeedback.mediumImpact();
  }

  static Future<void> triggerLight() async {
    await HapticFeedback.lightImpact();
  }
}
