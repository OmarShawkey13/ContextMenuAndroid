import 'dart:ui';
import 'package:context_menu_android/core/theme/colors.dart';
import 'package:context_menu_android/features/context_menu/data/models/context_menu_item.dart';
import 'package:context_menu_android/features/context_menu/presentation/screen/ios_style_context_menu.dart';
import 'package:context_menu_android/features/context_menu/presentation/widget/context_menu_action_tile.dart';
import 'package:flutter/material.dart';

/// The actual context menu container and actions list.
class ContextMenuPanel extends StatelessWidget {
  final IosStyleContextMenu widget;
  final List<ContextMenuItem> menu;
  final List<Animation<double>> animations;
  final Color? backgroundMenuColor;
  final bool hasBack;
  final VoidCallback onBack;
  final void Function(List<ContextMenuItem>) onOpenSubMenu;
  final void Function([VoidCallback? action]) onClose;

  const ContextMenuPanel({
    super.key,
    required this.widget,
    required this.menu,
    required this.animations,
    required this.backgroundMenuColor,
    required this.hasBack,
    required this.onBack,
    required this.onOpenSubMenu,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color contentColor = ColorsManager.getContentColor(isDark);
    final Color dividerColor =
        widget.dividerColor ?? ColorsManager.getDividerColor(isDark);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.45,
      ),
      child: Container(
        width: 250,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundMenuColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeOutCubic,
              transitionBuilder: (Widget child, Animation<double> animation) {
                final bool isPushing =
                    child.key == ValueKey<int>(menu.hashCode);
                final Tween<Offset> slideTween = isPushing
                    ? Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      )
                    : Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,
                      );

                return SlideTransition(
                  position: slideTween.animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: SingleChildScrollView(
                key: ValueKey<int>(menu.hashCode),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasBack)
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          leading: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 18,
                            color: contentColor,
                          ),
                          title: Text(
                            'Back',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: contentColor,
                            ),
                          ),
                          onTap: onBack,
                        ),
                      ),
                    if (hasBack)
                      Divider(height: 1, thickness: 0.5, color: dividerColor),
                    ...List.generate(menu.length, (index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ContextMenuActionTile(
                            action: menu[index],
                            animation: animations[index],
                            isLast: index == menu.length - 1,
                            widget: widget,
                            onOpenSubMenu: onOpenSubMenu,
                            onClose: onClose,
                          ),
                          if (index < menu.length - 1)
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: dividerColor,
                              indent: 0,
                              endIndent: 0,
                            ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
