import 'package:context_menu_android/features/context_menu/data/models/context_menu.dart';
import 'package:context_menu_android/features/context_menu/presentation/screen/ios_style_context_menu.dart';
import 'package:context_menu_android/features/context_menu/presentation/utils/responsive_size.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/context_menu_action_tile.dart';
import 'package:flutter/material.dart';

/// The actual context menu container and actions list.
class ContextMenuPanel extends StatelessWidget {
  final IosStyleContextMenu widget;
  final List<ContextMenuAndroid> menu;
  final List<Animation<double>> animations;
  final Color? backgroundMenuColor;
  final bool hasBack;
  final VoidCallback onBack;
  final void Function(List<ContextMenuAndroid>) onOpenSubMenu;
  final AnimationController menuController;
  final AnimationController childController;

  const ContextMenuPanel({
    super.key,
    required this.widget,
    required this.menu,
    required this.animations,
    required this.backgroundMenuColor,
    required this.hasBack,
    required this.onBack,
    required this.onOpenSubMenu,
    required this.menuController,
    required this.childController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getResponsiveSize(context: context, size: 280),
      decoration: BoxDecoration(
        color:
            backgroundMenuColor ??
            (widget.isDark ?? false
                ? Colors.black.withValues(alpha: 0.9)
                : Colors.white.withValues(alpha: 0.7)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasBack)
            ListTile(
              leading: const Icon(Icons.arrow_back_ios_new_outlined),
              title: const Text('Back'),
              onTap: onBack,
            ),
          ...List.generate(menu.length, (index) {
            return ContextMenuActionTile(
              action: menu[index],
              animation: animations[index],
              isLast: index == menu.length - 1,
              widget: widget,
              onOpenSubMenu: onOpenSubMenu,
              menuController: menuController,
              childController: childController,
            );
          }),
        ],
      ),
    );
  }
}
