import 'dart:math';
import 'package:context_menu_android/features/context_menu/presentation/widget/blur_background.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/context_menu_child.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/context_menu_panel.dart';
import 'package:flutter/material.dart';
import 'package:context_menu_android/features/context_menu/data/models/context_menu.dart';

/// A customizable iOS-style context menu for Android (using a blur background and smooth animations).
///
/// Displays a dialog overlay with a blurred background, a target widget [child],
/// and a list of tappable [actions].
///
/// This widget provides an iOS-like context menu experience, including delete highlighting,
/// optional dark mode, and animated transitions for each action item.
///
/// Example usage:
/// ```dart
/// showDialog(
///   context: context,
///   builder: (_) => IosStyleContextMenu(
///     child: YourWidget(),
///     actions: [
///       ContextMenuAndroid(
///         icon: Icons.edit,
///         label: 'Edit',
///         onTap: () => print('Edit tapped'),
///       ),
///     ],
///   ),
/// );
/// ```
/// A customizable iOS-style context menu for Android (blur + smooth animations).
///
/// Displays a dialog overlay with:
/// - Blurred background
/// - Animated target [child]
/// - A list of tappable [actions]
///
/// Supports:
/// - Dark mode
/// - Delete highlighting
/// - Nested sub-menus
/// - Responsive sizing
class IosStyleContextMenu extends StatefulWidget {
  final Widget child;
  final List<ContextMenuAndroid> actions;
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

  const IosStyleContextMenu({
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
  late List<List<ContextMenuAndroid>> menuStack;

  @override
  void initState() {
    super.initState();
    menuStack = [widget.actions];
    _initChildAnimation();
    _initMenuAnimation();
    _startAnimations();
  }

  /// Initializes animation for the target child (scale + fade).
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

  /// Initializes animations for context menu actions.
  void _initMenuAnimation() {
    menuController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: min(600, 80 * menuStack.last.length),
      ),
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

  /// Starts menu + child animations with slight delay.
  void _startAnimations() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await childController.forward();
    await menuController.forward();
  }

  /// Opens a nested sub-menu.
  void _openSubMenu(List<ContextMenuAndroid> subMenu) {
    setState(() {
      menuStack.add(subMenu);
      _initMenuAnimation();
      menuController.forward(from: 0);
    });
  }

  /// Closes current sub-menu.
  void _closeSubMenu() {
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
    return GestureDetector(
      onTap: () async {
        await menuController.reverse();
        await childController.reverse();
        if (context.mounted) Navigator.pop(context);
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BlurBackground(
              backgroundColor: widget.backgroundColor,
            ),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ContextMenuChild(
                    controller: childController,
                    opacity: childOpacity,
                    child: widget.child,
                  ),
                  const SizedBox(height: 12),
                  ContextMenuPanel(
                    widget: widget,
                    menu: menuStack.last,
                    animations: actionAnimations,
                    hasBack: menuStack.length > 1,
                    onBack: _closeSubMenu,
                    onOpenSubMenu: _openSubMenu,
                    menuController: menuController,
                    childController: childController,
                    backgroundMenuColor: widget.backgroundMenuColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


