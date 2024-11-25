import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final Color? color;

  const TextLabel(
    this.text, {
    super.key,
    this.style,
    this.color,
  });

  @override
  Widget build(BuildContext context) => Text(
        text ?? '',
        style: style?.copyWith(
          color: color,
        ),
      );
}
