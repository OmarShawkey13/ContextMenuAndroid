import 'package:context_menu_android/features/context_menu/data/models/context_menu_item.dart';
import 'package:context_menu_android/features/context_menu/presentation/screen/ios_style_context_menu.dart';
import 'package:flutter/material.dart';

/// A wrapper widget that simplifies the usage of the context menu.
/// It listens for a long press and automatically shows the menu.
class ContextMenuWrapper extends StatelessWidget {
  /// The widget that triggers the context menu.
  final Widget child;

  /// The list of actions to show in the menu.
  final List<ContextMenuItem> actions;

  /// Optional: Force dark mode.
  final bool? isDark;

  /// Optional: Custom text style for action labels.
  final TextStyle? textStyle;

  /// Optional: Background color of the whole overlay.
  final Color? backgroundColor;

  /// Optional: Background color of the menu container.
  final Color? backgroundMenuColor;

  /// Optional: Divider color between menu items.
  final Color? dividerColor;

  /// Optional: Icon color.
  final Color? iconColor;

  /// Optional: Alignment of the menu.
  final AlignmentGeometry? menuAlignment;

  /// Optional: Padding around the content.
  final EdgeInsetsGeometry? contentPadding;

  /// Optional: Font size for text.
  final double? textSize;

  /// Optional: Icon size.
  final double? iconSize;

  /// Optional: Intensity of the blur.
  final double? blurSigma;

  const ContextMenuWrapper({
    super.key,
    required this.child,
    required this.actions,
    this.isDark,
    this.textStyle,
    this.backgroundColor,
    this.backgroundMenuColor,
    this.dividerColor,
    this.iconColor,
    this.menuAlignment,
    this.contentPadding,
    this.textSize,
    this.iconSize,
    this.blurSigma,
  });

  void _showMenu(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => IosStyleContextMenu(
        actions: actions,
        isDark: isDark,
        textStyle: textStyle,
        backgroundColor: backgroundColor,
        backgroundMenuColor: backgroundMenuColor,
        dividerColor: dividerColor,
        iconColor: iconColor,
        menuAlignment: menuAlignment,
        contentPadding: contentPadding,
        textSize: textSize,
        iconSize: iconSize,
        blurSigma: blurSigma,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onLongPress: () => _showMenu(context), child: child);
  }
}
