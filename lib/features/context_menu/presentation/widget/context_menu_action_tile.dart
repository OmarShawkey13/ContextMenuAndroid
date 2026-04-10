import 'package:context_menu_android/features/context_menu/data/models/context_menu_item.dart';
import 'package:context_menu_android/features/context_menu/presentation/screen/ios_style_context_menu.dart';
import 'package:context_menu_android/features/context_menu/presentation/utils/responsive_size.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/haptic_feedback_wrapper.dart';
import 'package:flutter/material.dart';

/// Single action tile inside the context menu.
class ContextMenuActionTile extends StatelessWidget {
  final ContextMenuItem action;
  final Animation<double> animation;
  final bool isLast;
  final IosStyleContextMenu widget;
  final void Function(List<ContextMenuItem>) onOpenSubMenu;
  final AnimationController menuController;
  final AnimationController childController;

  const ContextMenuActionTile({
    super.key,
    required this.action,
    required this.animation,
    required this.isLast,
    required this.widget,
    required this.onOpenSubMenu,
    required this.menuController,
    required this.childController,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isDestructive = action.effectiveIsDestructive;

    // Determine the base color based on theme and properties
    final Color defaultColor = isDark ? Colors.white : Colors.black;
    final Color contentColor = isDestructive
        ? Colors.red
        : (widget.iconColor ?? defaultColor);

    return FadeTransition(
      opacity: animation,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if (action.hasSubMenu) {
              onOpenSubMenu(action.subMenu!);
            } else {
              await HapticFeedbackHelper.triggerLight();
              await menuController.reverse();
              await childController.reverse();
              if (context.mounted) {
                Navigator.pop(context);
                action.onTap?.call();
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: getResponsiveSize(context: context, size: 14),
              horizontal: getResponsiveSize(context: context, size: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    action.label,
                    style:
                        widget.textStyle?.copyWith(
                          color: isDestructive ? Colors.red : null,
                        ) ??
                        TextStyle(
                          color: contentColor,
                          fontSize: widget.textSize ?? 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                Icon(
                  action.icon,
                  color: contentColor,
                  size: widget.iconSize ?? 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
