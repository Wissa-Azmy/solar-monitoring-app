import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void navigateToRoot() => Navigator.of(this).popUntil(
        (route) => route.settings.name == Navigator.defaultRouteName,
  );

  void navigateTo(String route, {Object? arguments}) =>
      Navigator.of(this).pushNamed(route, arguments: arguments);

  Object? get arguments => ModalRoute.of(this)?.settings.arguments;

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);
}

extension ThemeExtension on BuildContext {
  TextTheme get font => Theme.of(this).textTheme;

  ColorScheme get color => Theme.of(this).colorScheme;
}