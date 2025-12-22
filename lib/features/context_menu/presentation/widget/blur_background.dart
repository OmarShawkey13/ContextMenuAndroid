import 'dart:ui';
import 'package:flutter/material.dart';

/// A full-screen blurred background used behind the context menu.
///
/// This widget:
/// - Applies a Gaussian blur effect
/// - Adds a semi-transparent dark overlay
/// - Helps focus the user's attention on the context menu
///
/// Used internally by [IosStyleContextMenu].
class BlurBackground extends StatelessWidget {
  final Color? backgroundColor;
  const BlurBackground({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 10,
        sigmaY: 10,
      ),
      child: Container(
        color: backgroundColor ?? Colors.black.withValues(alpha: 0.15),
      ),
    );
  }
}
