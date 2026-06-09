import 'package:context_menu_android/features/context_menu/data/models/context_menu_item.dart';
import 'package:context_menu_android/features/context_menu/presentation/screen/ios_style_context_menu.dart';
import 'package:flutter/material.dart';

/// Single action tile inside the context menu.
class ContextMenuActionTile extends StatelessWidget {
  final ContextMenuItem action;
  final Animation<double> animation;
  final bool isLast;
  final IosStyleContextMenu widget;
  final void Function(List<ContextMenuItem>) onOpenSubMenu;
  final void Function([VoidCallback? action]) onClose;

  const ContextMenuActionTile({
    super.key,
    required this.action,
    required this.animation,
    required this.isLast,
    required this.widget,
    required this.onOpenSubMenu,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isDestructive = action.effectiveIsDestructive;

    // Determine the base color based on theme and properties
    final Color defaultColor = isDark
        ? Colors.white
        : Colors.black.withValues(alpha: 0.8);
    final Color contentColor = !action.enabled
        ? Colors.grey
        : (isDestructive ? Colors.red : (widget.iconColor ?? defaultColor));

    return Semantics(
      button: true,
      enabled: action.enabled,
      label: action.label,
      hint: action.subtitle,
      child: FadeTransition(
        opacity: animation,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action.enabled
                ? () async {
                    if (action.hasSubMenu) {
                      onOpenSubMenu(action.subMenu!);
                    } else {
                      onClose(action.onTap);
                    }
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          action.label,
                          style:
                              widget.textStyle?.copyWith(color: contentColor) ??
                              TextStyle(
                                color: contentColor,
                                fontSize: widget.textSize ?? 16,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        if (action.subtitle != null)
                          Text(
                            action.subtitle!,
                            style: TextStyle(
                              color: contentColor.withValues(alpha: 0.6),
                              fontSize: (widget.textSize ?? 16) * 0.75,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    action.hasSubMenu ? Icons.chevron_right : action.icon,
                    color: contentColor,
                    size: widget.iconSize ?? 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
