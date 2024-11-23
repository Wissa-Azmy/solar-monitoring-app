import 'app_error.dart';

enum ExternalError implements AppError {
  none,
  serverError,
  badRequest,
  unknownError;

  @override
  String get localizedDescription {
    switch (this) {
      case ExternalError.serverError:
        // TODO: User facing string should be localized
        return 'Server is not available';
      case ExternalError.badRequest:
        return 'Bad Request';
      case ExternalError.unknownError:
        return 'Something went wrong.\nUnknown error!';
      case ExternalError.none:
        return '';
    }
  }
}
