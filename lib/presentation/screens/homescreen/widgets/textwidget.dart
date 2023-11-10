import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? weight;
  final double? size;
  final TextOverflow? overflow;
  final TextAlign? aligntext;

  const TextWidget(
      {super.key,
      required this.text,
      this.color,
      this.weight,
      this.size,
      this.overflow,
      this.aligntext});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: aligntext ?? TextAlign.center,
      style: TextStyle(
          color: color,
          fontWeight: weight,
          fontSize: size,
          fontStyle: FontStyle.italic),
    );
  }
}
