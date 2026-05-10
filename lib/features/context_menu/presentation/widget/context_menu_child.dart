import 'package:flutter/material.dart';

/// Animated target widget shown above the context menu.
class ContextMenuChild extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> opacity;
  final Widget child;

  const ContextMenuChild({
    super.key,
    required this.controller,
    required this.opacity,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(
        begin: 1.0,
        end: 1.05,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut)),
      child: FadeTransition(opacity: opacity, child: child),
    );
  }
}
