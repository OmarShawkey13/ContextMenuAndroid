import 'dart:math';
import 'dart:ui';
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
class IosStyleContextMenu extends StatefulWidget {
  final Widget child;
  final List<ContextMenuAndroid> actions;
  final bool? isDark;
  final TextStyle? textStyle;
  final Color? backgroundColor;
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
    initChildAnimation();
    initMenuAnimation();
    startAnimations();
  }

  /// Initializes the animation for the main child widget (scaling and fading).
  void initChildAnimation() {
    childController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    childOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: childController, curve: Curves.easeInOut),
    );
  }

  /// Initializes the animations for each action in the context menu (fade and slide).
  void initMenuAnimation() {
    // ✅ Dispose previous controller only if already initialized
    try {
      menuController.dispose();
    } catch (_) {
      // ignore if not yet initialized
    }

    final duration = Duration(
      milliseconds: min(600, 80 * menuStack.last.length),
    );

    menuController = AnimationController(vsync: this, duration: duration);

    actionAnimations = List.generate(menuStack.last.length, (index) {
      final start = index / menuStack.last.length;
      final end = (index + 1) / menuStack.last.length;
      return CurvedAnimation(
        parent: menuController,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });
  }

  /// Starts animations with a slight delay for smoothness.
  void startAnimations() {
    Future.delayed(const Duration(milliseconds: 100), () async {
      await childController.forward();
      await menuController.forward();
    });
  }

  @override
  void dispose() {
    childController.dispose();
    menuController.dispose();
    super.dispose();
  }

  /// Opens a sub-menu by adding it to the menu stack and starting animations.
  void openSubMenu(List<ContextMenuAndroid> subMenu) {
    setState(() {
      menuStack.add(subMenu);
      initMenuAnimation();
      menuController.forward(from: 0);
    });
  }

  /// Closes the current sub-menu by removing it from the menu stack and restarting animations.
  void closeSubMenu() {
    if (menuStack.length > 1) {
      setState(() {
        menuStack.removeLast();
        initMenuAnimation();
        menuController.forward(from: 0);
      });
    }
  }

  /// 🔧 تُستخدم لحساب حجم الخط النهائي بناءً على:
  /// 1. textStyle المُرسل (إذا وُجد)
  /// 2. وإذا لم يُرسل، يتم استخدام الحجم المخصص `textSize`
  /// 3. يتم حساب الحجم النهائي بطريقة responsive بناءً على عرض الجهاز
  TextStyle getTextStyle(BuildContext context, bool isDelete) {
    final baseColor = isDelete
        ? Colors.red
        : widget.textStyle?.color ??
              (widget.isDark ?? false ? Colors.white : Colors.black);

    final fontSize = getResponsiveSize(
      context: context,
      size: widget.textSize ?? 16,
    );

    return widget.textStyle?.copyWith(
          color: baseColor,
          fontSize: fontSize,
          fontWeight: isDelete ? FontWeight.w500 : FontWeight.normal,
        ) ??
        TextStyle(
          color: baseColor,
          fontSize: fontSize,
          fontWeight: isDelete ? FontWeight.w500 : FontWeight.normal,
        );
  }

  /// Returns the appropriate icon color based on whether the action is a delete action or not.
  Color getIconColor(bool isDelete) {
    return isDelete
        ? Colors.red
        : widget.iconColor ??
              (widget.isDark ?? false ? Colors.white : Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    final currentMenu = menuStack.last;

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
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withValues(alpha: 0.15)),
            ),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(
                        parent: childController,
                        curve: Curves.easeInExpo,
                      ),
                    ),
                    child: FadeTransition(
                      opacity: childOpacity,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                          maxHeight: MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding:
                        widget.contentPadding ??
                        EdgeInsets.symmetric(
                          horizontal: getResponsiveSize(
                            context: context,
                            size: 16,
                          ),
                        ),
                    child: Align(
                      alignment: widget.menuAlignment ?? Alignment.center,
                      child: Container(
                        width: getResponsiveSize(context: context, size: 280),
                        decoration: BoxDecoration(
                          color: widget.isDark ?? false
                              ? Colors.black.withValues(alpha: 0.9)
                              : Colors.white.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (menuStack.length > 1)
                                ListTile(
                                  leading: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                  ),
                                  title: const Text("Back"),
                                  onTap: closeSubMenu,
                                ),
                              ...List.generate(currentMenu.length, (index) {
                                final action = currentMenu[index];
                                final isDelete = action.label
                                    .toLowerCase()
                                    .contains('delete');
                                return FadeTransition(
                                  opacity: actionAnimations[index],
                                  child: SlideTransition(
                                    position: actionAnimations[index].drive(
                                      Tween<Offset>(
                                        begin: const Offset(0, 0.1),
                                        end: Offset.zero,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            if (action.hasSubMenu) {
                                              openSubMenu(action.subMenu!);
                                            } else {
                                              await menuController.reverse();
                                              await childController.reverse();
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                                action.onTap?.call();
                                              }
                                            }
                                          },
                                          borderRadius: index == 0
                                              ? const BorderRadius.vertical(
                                                  top: Radius.circular(16),
                                                )
                                              : index == currentMenu.length - 1
                                              ? const BorderRadius.vertical(
                                                  bottom: Radius.circular(16),
                                                )
                                              : BorderRadius.zero,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: getResponsiveSize(
                                                context: context,
                                                size: 12,
                                              ),
                                              horizontal: getResponsiveSize(
                                                context: context,
                                                size: 20,
                                              ),
                                            ),
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  action.label,
                                                  style: getTextStyle(
                                                    context,
                                                    isDelete,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      action.icon,
                                                      color: getIconColor(
                                                        isDelete,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (index != currentMenu.length - 1)
                                          Divider(
                                            height: 1,
                                            color:
                                                widget.dividerColor ??
                                                (widget.isDark ?? false
                                                    ? Colors.white12
                                                    : Colors.grey[300]),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
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

/// Calculates a responsive size based on screen width.
/// Helps maintain consistent layout proportions across various device sizes.
///
/// Example:
/// If `size = 280`, and screen width is 411 (Pixel 2 XL),
/// then the returned value will be equal to `280`.
double getResponsiveSize({
  required BuildContext context,
  required double size,
}) {
  final width = MediaQuery.of(
    context,
  ).size.width.clamp(320.0, 600.0); // ✅ More robust
  return (size * width) / 411.0;
}
