import 'package:context_menu_android/features/context_menu/data/models/context_menu.dart';
import 'package:context_menu_android/features/context_menu/presentation/screen/ios_style_context_menu.dart';
import 'package:context_menu_android/features/context_menu/presentation/utils/responsive_size.dart';
import 'package:flutter/material.dart';

/// Single action tile inside the context menu.
class ContextMenuActionTile extends StatelessWidget {
  final ContextMenuAndroid action;
  final Animation<double> animation;
  final bool isLast;
  final IosStyleContextMenu widget;
  final void Function(List<ContextMenuAndroid>) onOpenSubMenu;
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
    final isDelete = action.label.toLowerCase().contains('delete');

    return FadeTransition(
      opacity: animation,
      child: InkWell(
        onTap: () async {
          if (action.hasSubMenu) {
            onOpenSubMenu(action.subMenu!);
          } else {
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
            vertical: getResponsiveSize(context: context, size: 12),
            horizontal: getResponsiveSize(context: context, size: 20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                action.label,
                style: widget.textStyle?.copyWith(
                  color: isDelete ? Colors.red : null,
                ) ??
                    TextStyle(
                      color: isDelete ? Colors.red : Colors.black,
                    ),
              ),
              Icon(
                action.icon,
                color: isDelete ? Colors.red : widget.iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
