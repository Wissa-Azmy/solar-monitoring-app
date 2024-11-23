import 'app_error.dart';

class DecodingError extends AppError {
  final String key;
  final String msg;
  DecodingError(this.key, this.msg);

  @override
  String get localizedDescription => 'Decoding error for key [$key]: $msg';
}