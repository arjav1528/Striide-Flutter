import 'package:flutter/material.dart';

/// Custom page transitions and animations utility class
class AppAnimations {
  // Duration constants
  static const Duration fastDuration = Duration(milliseconds: 200);
  static const Duration normalDuration = Duration(milliseconds: 300);
  static const Duration slowDuration = Duration(milliseconds: 500);

  /// Fade transition page route
  static PageRouteBuilder<T> fadeTransition<T>(
    Widget page, {
    Duration duration = normalDuration,
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: curve),
          child: child,
        );
      },
    );
  }

  /// Slide transition page route
  static PageRouteBuilder<T> slideTransition<T>(
    Widget page, {
    Duration duration = normalDuration,
    Curve curve = Curves.easeInOut,
    Offset begin = const Offset(1.0, 0.0),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
      },
    );
  }

  /// Fade and slide combination transition
  static PageRouteBuilder<T> fadeSlideTransition<T>(
    Widget page, {
    Duration duration = normalDuration,
    Curve curve = Curves.easeInOut,
    Offset begin = const Offset(0.0, 0.3),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeAnimation = CurvedAnimation(parent: animation, curve: curve);

        final slideAnimation = Tween<Offset>(
          begin: begin,
          end: Offset.zero,
        ).animate(fadeAnimation);

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: slideAnimation, child: child),
        );
      },
    );
  }

  /// Scale transition page route
  static PageRouteBuilder<T> scaleTransition<T>(
    Widget page, {
    Duration duration = normalDuration,
    Curve curve = Curves.elasticOut,
    double begin = 0.8,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: begin,
            end: 1.0,
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}

/// Animated container wrapper for fade in animations
class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Offset? slideOffset;

  const FadeInWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.slideOffset,
  });

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);

    if (widget.slideOffset != null) {
      _slideAnimation = Tween<Offset>(
        begin: widget.slideOffset!,
        end: Offset.zero,
      ).animate(_fadeAnimation);
    }

    // Start animation after delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child:
          _slideAnimation != null
              ? SlideTransition(position: _slideAnimation!, child: widget.child)
              : widget.child,
    );
  }
}

/// Staggered animation list wrapper
class StaggeredList extends StatelessWidget {
  final List<Widget> children;
  final Duration itemDelay;
  final Duration itemDuration;
  final Curve curve;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const StaggeredList({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 100),
    this.itemDuration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOut,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children:
          children.asMap().entries.map((entry) {
            final index = entry.key;
            final child = entry.value;

            return FadeInWidget(
              duration: itemDuration,
              delay: itemDelay * index,
              curve: curve,
              slideOffset: const Offset(0.0, 0.3),
              child: child,
            );
          }).toList(),
    );
  }
}

/// Animated button wrapper
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;
  final double scaleValue;

  const AnimatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.duration = const Duration(milliseconds: 150),
    this.scaleValue = 0.95,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleValue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}
