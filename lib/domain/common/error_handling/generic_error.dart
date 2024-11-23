import 'app_error.dart';

class GenericError extends AppError {
  final dynamic error;

  GenericError(this.error);

  @override
  String get localizedDescription {
    final currentError = error;

    if (currentError is AppError) {
      return currentError.localizedDescription;
    }
    if (currentError is StateError) {
      return currentError.message;
    }
    if (currentError is TypeError) {
      return currentError.toString();
    }
    if (currentError is Exception) {
      return currentError.toString();
    }
    if (currentError is String) {
      return currentError;
    }

    // log the type of the error to handle it correctly
    logger.d(error.runtimeType, error: error);

    // TODO: User facing string should be localized
    return 'Unknown Error';
  }

  @override
  String toString() => localizedDescription;
}