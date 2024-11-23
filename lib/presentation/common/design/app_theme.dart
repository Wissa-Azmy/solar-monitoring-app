import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: _lightColor,
    textTheme: _textTheme,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    colorScheme: _darkColor,
    textTheme: _textTheme,
  );

  // MARK: - TextTheme
  static TextTheme get _textTheme => ThemeData.light().textTheme.copyWith(
        bodySmall: const TextStyle(
          fontSize: 14,
        ),
        bodyMedium: const TextStyle(
          fontSize: 16,
        ),
        bodyLarge: const TextStyle(
          fontSize: 20,
        ),
        // and so on...
      );

  // MARK: - ColorSchemes
  static final _lightColor =
      ThemeData.light(useMaterial3: true).colorScheme.copyWith(
            primary: Colors.lightBlueAccent,
            secondary: Colors.blue.shade900,
            surfaceTint: Colors.white,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
            // and so on...
          );

  static final _darkColor =
      ThemeData.dark(useMaterial3: true).colorScheme.copyWith(
            primary: _lightColor.inversePrimary,
            secondary: Colors.blue.shade900,
            surfaceTint: Colors.white,
            onPrimary: Colors.white,
            surface: Colors.black,
            onSurface: Colors.white,
            // and so on...
          );
}

extension FontStyles on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w700);
}
