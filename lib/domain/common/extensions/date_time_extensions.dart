import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get stringDate => DateFormat('yyyy-MM-dd').format(this);
  static DateTime get yearFromNow => DateTime.now().subtract(const Duration(days: 365));
}