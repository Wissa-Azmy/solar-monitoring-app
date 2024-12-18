import 'package:equatable/equatable.dart';

import '../../../domain/common/error_handling/app_error.dart';
import '../../../domain/common/error_handling/external_error.dart';

enum StateStatus {
  empty,
  loading,
  success,
  failure;
}

class BaseState extends Equatable {
  final StateStatus status;
  final AppError error;

  bool get isEmpty => status == StateStatus.empty;

  bool get isLoading => status == StateStatus.loading;

  bool get isSuccessful => status == StateStatus.success;

  bool get isFailure => status == StateStatus.failure;

  const BaseState({
    StateStatus? status,
    AppError? error,
  })  : status = status ?? StateStatus.empty,
        error = error ?? ExternalError.none;

  BaseState copyWith({
    StateStatus? status,
    AppError? error,
  }) =>
      BaseState(
        status: status,
        error: error,
      );

  @override
  List<Object?> get props => [status, error];

  @override
  String toString() {
    return '''\t
      status: $status, 
      error: $error,\n''';
  }
}