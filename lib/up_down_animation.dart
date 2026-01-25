import 'package:flutter/material.dart';

extension UpDownAnimation on Widget {
  Widget upDown({
    Duration duration = const Duration(seconds: 2),
    double offset = 10,
  }) {
    return _UpDownWrapper(
      duration: duration,
      offset: offset,
      child: this,
    );
  }
}

class _UpDownWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const _UpDownWrapper({
    required this.child,
    required this.duration,
    required this.offset,
  });

  @override
  State<_UpDownWrapper> createState() => _UpDownWrapperState();
}

class _UpDownWrapperState extends State<_UpDownWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: widget.offset,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(0, -_animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
