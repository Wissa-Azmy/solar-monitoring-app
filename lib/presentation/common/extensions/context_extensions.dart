import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
}

extension ThemeExtension on BuildContext {
  TextTheme get font => Theme.of(this).textTheme;

  ColorScheme get color => Theme.of(this).colorScheme;
}
