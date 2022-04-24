import 'dart:math';

import 'package:flutter/material.dart';

class DrawerControl {
  late void Function() open;

  late void Function() close;

  late void Function() toggle;
}

class Flutter3dDrawer extends StatefulWidget {
  final DrawerControl controller;
  final Widget drawer;
  final Widget body;
  final Duration? duration;
  final double maxSlide;
  final Color backgroundColor;
  final Curve curve;

  const Flutter3dDrawer({
    Key? key,
    required this.controller,
    required this.drawer,
    required this.body,
    this.backgroundColor = const Color(0xffefefef),
    this.maxSlide = 300,
    this.duration,
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  State<Flutter3dDrawer> createState() => _Flutter3dDrawerState();
}

class _Flutter3dDrawerState extends State<Flutter3dDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController drawerAnimation;
  late Animation<double> animationTween;
  bool canBeDragged = false;

  void open() {
    drawerAnimation.forward();
  }

  void close() {
    drawerAnimation.reverse();
  }

  void toggle() {
    if (drawerAnimation.value == 0) {
      open();
    } else {
      close();
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.open = open;
    widget.controller.close = close;
    widget.controller.toggle = toggle;

    drawerAnimation = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 300),
    );
    animationTween = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: drawerAnimation,
        curve: widget.curve,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: toggle,
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: Material(
        color: widget.backgroundColor,
        child: Stack(
          children: [
            GestureDetector(
              onTap: close,
              child: Container(
                color: Colors.transparent,
              ),
            ),
            AnimatedBuilder(
              animation: drawerAnimation,
              builder: (context, value) {
                return Transform.translate(
                  offset:
                      Offset(widget.maxSlide * (animationTween.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(pi / 2 * (1 - animationTween.value)),
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: widget.maxSlide,
                      child: widget.drawer,
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: drawerAnimation,
              builder: (context, value) {
                return Transform.translate(
                  offset: Offset(widget.maxSlide * animationTween.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-pi / 2 * animationTween.value),
                    alignment: Alignment.centerLeft,
                    child: widget.body,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenLeft = drawerAnimation.isDismissed &&
        details.globalPosition.dx < widget.maxSlide / 4;
    bool isDragCloseFromRight = drawerAnimation.isCompleted &&
        details.globalPosition.dx > widget.maxSlide - (widget.maxSlide / 4);

    canBeDragged = isDragOpenLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (canBeDragged) {
      double delta = (details.primaryDelta ?? 0) / widget.maxSlide;
      drawerAnimation.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (drawerAnimation.isDismissed || drawerAnimation.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() > 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      drawerAnimation.fling(velocity: visualVelocity);
    } else if (drawerAnimation.value < 0.5) {
      close();
    } else {
      open();
    }
  }
}
