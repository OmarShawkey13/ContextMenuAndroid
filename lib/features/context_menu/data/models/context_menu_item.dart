import 'package:flutter/material.dart';

/// Represents an action in the context menu.
///
/// Each action contains an icon, a label, and a callback function
/// that is triggered when the user taps the action.
class ContextMenuItem {
  /// The icon displayed next to the label.
  final IconData icon;

  /// The text label for the menu action.
  final String label;

  /// The function that is executed when the action is tapped.
  final VoidCallback? onTap;

  /// An optional list of sub-menu items.
  final List<ContextMenuItem>? subMenu;

  /// Whether this action is destructive (e.g., Delete).
  /// If null, it will be inferred from the label.
  final bool? isDestructive;

  /// Creates a [ContextMenuItem] item with [icon], [label], and [onTap] callback, and optional [subMenu].
  const ContextMenuItem({
    required this.icon,
    required this.label,
    this.onTap,
    this.subMenu,
    this.isDestructive,
  });

  bool get hasSubMenu => subMenu != null && subMenu!.isNotEmpty;

  bool get effectiveIsDestructive =>
      isDestructive ?? label.toLowerCase().contains('delete');
}
