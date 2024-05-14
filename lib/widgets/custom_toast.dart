import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final Color backgroundColor;

  const CustomToast({
    super.key,
    required this.message,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

void showToast(BuildContext context, String message, Color backgroundColor) {
  final overlay = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.82,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: CustomToast(message: message, backgroundColor: backgroundColor),
      ),
    ),
  );

  Overlay.of(context).insert(overlay);

  Future.delayed(const Duration(seconds: 2), () {
    overlay.remove();
  });
}