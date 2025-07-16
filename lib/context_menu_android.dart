import 'dart:ui';
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

/// Displays a Cupertino-style context menu overlay with blur background and actions.
///
/// This widget opens as a dialog and displays a [child] widget followed by a list of [actions].
///
/// You can customize colors, text style, padding, and whether it's shown in dark mode.
///
/// Example:
/// ```dart
/// iOSStyleContextMenu(
///   context,
///   child: YourWidget(),
///   actions: [
///     ContextMenuAndroid(
///       icon: Icons.edit,
///       label: 'Edit',
///       onTap: () => print('Edit tapped'),
///     ),
///   ],
/// );
/// ```
Widget iOSStyleContextMenu(
  BuildContext context, {
  required Widget child,
  required List<ContextMenuAndroid> actions,
  bool isDark = false,
  TextStyle? textStyle,
  Color? backgroundColor,
  Color? dividerColor,
  Color? iconColor,
  EdgeInsetsGeometry? contentPadding,
}) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
          GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  scale: 1.05,
                  duration: const Duration(milliseconds: 300),
                  child: child,
                ),
                const SizedBox(height: 12),
                Padding(
                  padding:
                      contentPadding ??
                      const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      width: getResponsiveSize(context: context, size: 280),
                      decoration: BoxDecoration(
                        color:
                            backgroundColor ??
                            (isDark
                                ? Colors.black.withValues(alpha: 0.9)
                                : Colors.white.withValues(alpha: 0.7)),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(actions.length, (index) {
                          final action = actions[index];
                          final isDelete = action.label.toLowerCase().contains(
                            'delete',
                          );
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  action.onTap();
                                },
                                borderRadius: index == 0
                                    ? const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      )
                                    : index == actions.length - 1
                                    ? const BorderRadius.vertical(
                                        bottom: Radius.circular(16),
                                      )
                                    : BorderRadius.zero,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 20,
                                  ),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        action.label,
                                        style:
                                            textStyle?.copyWith(
                                              color: isDelete
                                                  ? Colors.red
                                                  : textStyle.color ??
                                                        (isDark
                                                            ? Colors.white
                                                            : Colors.black),
                                              fontWeight: isDelete
                                                  ? FontWeight.w500
                                                  : FontWeight.normal,
                                            ) ??
                                            TextStyle(
                                              fontSize: 16,
                                              color: isDelete
                                                  ? Colors.red
                                                  : (isDark
                                                        ? Colors.white
                                                        : Colors.black),
                                              fontWeight: isDelete
                                                  ? FontWeight.w500
                                                  : FontWeight.normal,
                                            ),
                                      ),
                                      Icon(
                                        action.icon,
                                        color: isDelete
                                            ? Colors.red
                                            : iconColor ??
                                                  (isDark
                                                      ? Colors.white
                                                      : Colors.black),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (index != actions.length - 1)
                                Divider(
                                  height: 1,
                                  color:
                                      dividerColor ??
                                      (isDark
                                          ? Colors.white12
                                          : Colors.grey[300]),
                                ),
                            ],
                          );
                        }),
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

/// Calculates a responsive width based on screen size and a reference size.
///
/// This helps maintain consistent visual proportions across different devices.
///
/// [size] should be based on a reference width of 411 (e.g., Pixel 2 XL).
double getResponsiveSize({
  required BuildContext context,
  required double size,
}) {
  final width = MediaQuery.of(context).size.width;
  return (size * width) / 411.0;
}
