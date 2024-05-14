import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final Duration duration;
  const ScrollToHideWidget(
      {super.key,
      required this.controller,
      required this.child,
      this.duration = const Duration(milliseconds: 800)});

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;
  double scrollPosition = 0;
  double scrollThreshold = 50;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(listen);
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
    setState(() {
      scrollPosition = widget.controller.position.pixels;
    });
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: widget.duration,
        height: isVisible ? 90 : 0,
        child: Wrap(
          children: [
            widget.child,
          ],
        ),
      );
}
