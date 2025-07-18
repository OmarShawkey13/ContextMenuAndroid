import 'package:flutter/material.dart';

/// Represents an action in the context menu.
///
/// Each action contains an icon, a label, and a callback function
/// that is triggered when the user taps the action.
class ContextMenuAndroid {
  /// The icon displayed next to the label.
  final IconData icon;

  /// The text label for the menu action.
  final String label;

  /// The function that is executed when the action is tapped.
  final VoidCallback onTap;

  /// Creates a [ContextMenuAndroid] item with [icon], [label], and [onTap] callback.
  ContextMenuAndroid({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
