import 'dart:math';
import 'package:context_menu_android/core/theme/colors.dart';
import 'package:context_menu_android/features/context_menu/data/models/context_menu_item.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/blur_background.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/context_menu_child.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/context_menu_panel.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/haptic_feedback_wrapper.dart';
import 'package:flutter/material.dart';

/// A customizable iOS-style context menu for Android (using a blur background and smooth animations).
class IosStyleContextMenu extends StatefulWidget {
  final Widget child;
  final List<ContextMenuItem> actions;
  final BorderRadiusGeometry? childBorderRadius;
  final bool? isDark;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? backgroundMenuColor;
  final Color? dividerColor;
  final Color? iconColor;
  final AlignmentGeometry? menuAlignment;
  final EdgeInsetsGeometry? contentPadding;
  final double? textSize;
  final double? iconSize;
  final double? blurSigma;
  final Rect childRect;

  const IosStyleContextMenu({
    super.key,
    required this.child,
    required this.actions,
    required this.childRect,
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
  });

  @override
  State<IosStyleContextMenu> createState() => _IosStyleContextMenuState();
}

class _IosStyleContextMenuState extends State<IosStyleContextMenu>
    with TickerProviderStateMixin {
  late AnimationController childController;
  late Animation<double> childOpacity;
  late AnimationController menuController;
  late List<Animation<double>> actionAnimations;
  late List<List<ContextMenuItem>> menuStack;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    menuStack = [widget.actions];
    _initChildAnimation();
    _initMenuAnimation();
    _startAnimations();
  }

  Future<void> _closeMenu([VoidCallback? action]) async {
    if (_isClosing) return;
    setState(() => _isClosing = true);

    await HapticFeedbackHelper.triggerLight();

    await Future.wait([menuController.reverse(), childController.reverse()]);

    if (mounted) {
      Navigator.pop(context);
      action?.call();
    }
  }

  void _initChildAnimation() {
    childController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    childOpacity = CurvedAnimation(
      parent: childController,
      curve: Curves.easeInOut,
    );
  }

  void _initMenuAnimation() {
    menuController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: min(600, 80 * menuStack.last.length)),
    );

    actionAnimations = List.generate(menuStack.last.length, (index) {
      final start = index / menuStack.last.length;
      final end = (index + 1) / menuStack.last.length;
      return CurvedAnimation(
        parent: menuController,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });
  }

  void _startAnimations() async {
    await HapticFeedbackHelper.triggerMedium();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;
    childController.forward();
    menuController.forward();
  }

  void _openSubMenu(List<ContextMenuItem> subMenu) {
    HapticFeedbackHelper.triggerLight();
    setState(() {
      menuStack.add(subMenu);
      _initMenuAnimation();
      menuController.forward(from: 0);
    });
  }

  void _closeSubMenu() {
    HapticFeedbackHelper.triggerLight();
    if (menuStack.length > 1) {
      setState(() {
        menuStack.removeLast();
        _initMenuAnimation();
        menuController.forward(from: 0);
      });
    }
  }

  @override
  void dispose() {
    childController.dispose();
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme =
        widget.isDark ?? (Theme.of(context).brightness == Brightness.dark);
    final screenSize = MediaQuery.of(context).size;

    // Calculate available space to decide position
    final double spaceAbove = widget.childRect.top;
    final double spaceBelow = screenSize.height - widget.childRect.bottom;
    final bool showMenuBelow = spaceBelow > spaceAbove;

    return GestureDetector(
      onTap: () => _closeMenu(),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            BlurBackground(
              backgroundColor:
                  widget.backgroundColor ??
                  ColorsManager.getBlurOverlayColor(isDarkTheme),
              blurSigma: widget.blurSigma,
            ),
            // The Child Preview
            Positioned(
              top: widget.childRect.top,
              left: widget.childRect.left,
              width: widget.childRect.width,
              height: widget.childRect.height,
              child: ContextMenuChild(
                controller: childController,
                opacity: childOpacity,
                child: ClipRRect(
                  borderRadius: widget.childBorderRadius ?? BorderRadius.zero,
                  child: widget.child,
                ),
              ),
            ),
            // The Menu Panel
            Positioned(
              top: showMenuBelow ? widget.childRect.bottom + 12 : null,
              bottom: showMenuBelow
                  ? null
                  : (screenSize.height - widget.childRect.top) + 12,
              left: 16,
              right: 16,
              child: FadeTransition(
                opacity: childOpacity,
                child: Align(
                  alignment: widget.menuAlignment ?? Alignment.center,
                  child: ContextMenuPanel(
                    widget: widget,
                    menu: menuStack.last,
                    animations: actionAnimations,
                    hasBack: menuStack.length > 1,
                    onBack: _closeSubMenu,
                    onOpenSubMenu: _openSubMenu,
                    onClose: _closeMenu,
                    backgroundMenuColor:
                        widget.backgroundMenuColor ??
                        ColorsManager.getMenuBackgroundColor(isDarkTheme),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
