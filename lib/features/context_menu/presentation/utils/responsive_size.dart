import 'package:flutter/material.dart';

/// Calculates a responsive size based on screen width.
///
/// Helps maintain consistent proportions across devices.
double getResponsiveSize({
  required BuildContext context,
  required double size,
}) {
  final width = MediaQuery.of(context).size.width.clamp(320.0, 600.0);
  return (size * width) / 411.0;
}
