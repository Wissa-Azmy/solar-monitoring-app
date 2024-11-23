import 'package:logger/logger.dart';
import 'package:solar_monitoring_app/domain/common/error_handling/external_error.dart';
import 'package:solar_monitoring_app/domain/common/error_handling/generic_error.dart';
import 'package:solar_monitoring_app/domain/common/extensions/iterable_extensions.dart';

final logger = Logger();

abstract class AppError implements Exception {
  String get localizedDescription;

  @override
  String toString() {
    return localizedDescription;
  }

  static AppError forCode(String errorCode) =>
      ExternalError.values
          .firstWhereOrNull((value) => value.name == errorCode) ??
      GenericError('Something went wrong.\nUnknown error!');
}
