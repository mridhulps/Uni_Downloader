import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final Widget child;

  const ButtonWidget({
    super.key,
    this.width,
    this.height,
    this.color,
    this.radius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius ?? 0.0)),
      child: Center(child: child),
    );
  }
}
