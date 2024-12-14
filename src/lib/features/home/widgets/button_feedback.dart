import 'package:flutter/material.dart';

class ButtonFeedback extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? feedbackColor;

  const ButtonFeedback({
    Key? key,
    required this.child,
    required this.onPressed,
    this.feedbackColor,
  }) : super(key: key);

  @override
  State<ButtonFeedback> createState() => _ButtonFeedbackState();
}

class _ButtonFeedbackState extends State<ButtonFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.feedbackColor,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
