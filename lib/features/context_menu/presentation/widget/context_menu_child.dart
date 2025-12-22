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
      scale: Tween(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInExpo),
      ),
      child: FadeTransition(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: child,
          ),
        ),
      ),
    );
  }
}
