import 'package:flutter/cupertino.dart';

abstract class AppSize {
  /// Double Value = 0.0
  static const zero = 0.0;

  /// Double Value = 8.0
  static const xSmall = 8.0;

  /// Double Value = 16.0
  static const small = 16.0;

  /// Double Value = 24.0
  static const medium = 24.0;

  /// Double Value = 32.0
  static const large = 32.0;

  /// Double Value = 40.0
  static const xLarge = 40.0;

  /// Takes all available space
  static const expandedSpace = Spacer();
}

extension SpaceExtension on double {
  /// Vertical Space
  SizedBox get vSpace => SizedBox(height: this);

  /// Horizontal Space
  SizedBox get hSpace => SizedBox(width: this);
}

extension PaddingExtension on double {
  /// All sides padding
  EdgeInsets get padding => EdgeInsets.all(this);

  /// Horizontal padding
  EdgeInsets get hPadding => EdgeInsets.symmetric(horizontal: this);

  /// Vertical padding
  EdgeInsets get vPadding => EdgeInsets.symmetric(vertical: this);

  /// Top padding
  EdgeInsets get topPadding => EdgeInsets.only(top: this);

  /// Bottom padding
  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: this);

  /// Right padding
  EdgeInsets get rightPadding => EdgeInsets.only(right: this);

  /// Left padding
  EdgeInsets get leftPadding => EdgeInsets.only(left: this);
}
