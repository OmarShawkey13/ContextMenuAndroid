import 'package:context_menu_android/features/context_menu/data/models/context_menu_item.dart';
import 'package:context_menu_android/features/context_menu/presentation/screen/ios_style_context_menu.dart';
import 'package:flutter/material.dart';

/// A wrapper widget that simplifies the usage of the context menu.
/// It listens for a long press and automatically shows the menu.
class ContextMenuWrapper extends StatefulWidget {
  /// The widget that triggers the context menu.
  final Widget child;

  /// The list of actions to show in the menu.
  final List<ContextMenuItem> actions;

  /// Optional: Border radius applied to the cloned child.
  final BorderRadiusGeometry? childBorderRadius;

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

  /// Optional: Position of the icon (leading or trailing). Defaults to trailing.
  final IconPosition iconPosition;

  /// Optional: Custom animation duration for opening.
  final Duration? openDuration;

  /// Optional: Custom animation duration for closing.
  final Duration? closeDuration;

  /// Optional: A builder to construct a custom preview widget instead of just scaling the child.
  final WidgetBuilder? previewBuilder;

  const ContextMenuWrapper({
    super.key,
    required this.child,
    required this.actions,
    this.childBorderRadius,
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
    this.iconPosition = IconPosition.trailing,
    this.openDuration,
    this.closeDuration,
    this.previewBuilder,
  });

  @override
  State<ContextMenuWrapper> createState() => _ContextMenuWrapperState();
}

class _ContextMenuWrapperState extends State<ContextMenuWrapper> {
  final GlobalKey _childKey = GlobalKey();

  void _showMenu(BuildContext context) {
    final RenderBox renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Rect rect = offset & renderBox.size;

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      builder: (_) => IosStyleContextMenu(
        actions: widget.actions,
        childRect: rect,
        childBorderRadius: widget.childBorderRadius,
        isDark: widget.isDark,
        textStyle: widget.textStyle,
        backgroundColor: widget.backgroundColor,
        backgroundMenuColor: widget.backgroundMenuColor,
        dividerColor: widget.dividerColor,
        iconColor: widget.iconColor,
        menuAlignment: widget.menuAlignment,
        contentPadding: widget.contentPadding,
        textSize: widget.textSize,
        iconSize: widget.iconSize,
        blurSigma: widget.blurSigma,
        iconPosition: widget.iconPosition,
        openDuration: widget.openDuration,
        closeDuration: widget.closeDuration,
        previewBuilder: widget.previewBuilder,
        child: widget.child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      onLongPressHint: 'Open context menu',
      child: GestureDetector(
        onLongPress: () => _showMenu(context),
        onSecondaryTapDown: (_) => _showMenu(context),
        child: KeyedSubtree(key: _childKey, child: widget.child),
      ),
    );
  }
}
