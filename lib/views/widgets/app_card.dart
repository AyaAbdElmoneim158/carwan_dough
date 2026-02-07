import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.scrollable = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    Widget card = LayoutBuilder(
      builder: (context, constraints) {
        final horizontalMargin = constraints.maxWidth * 0.05;

        return Center(
          child: Container(
            width: constraints.maxWidth > 720 ? 720 : constraints.maxWidth - horizontalMargin * 2,
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: padding,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: child,
          ),
        );
      },
    );

    if (scrollable) {
      card = SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: card,
      );
    }

    return card;
  }
}
