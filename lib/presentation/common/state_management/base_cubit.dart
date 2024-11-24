import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/common/error_handling/external_error.dart';
import '../../../domain/common/error_handling/generic_error.dart';
import 'base_state.dart';

class BaseCubit<T extends BaseState> extends BlocBase<T> {
  BaseCubit(super.state);

  void emitEmpty([T? updatedState]) {
    final newState = updatedState ?? state;
    emit(
      (newState.copyWith(
        status: StateStatus.empty,
        error: ExternalError.none,
      ) as T),
    );
  }

  void emitLoading([T? updatedState]) {
    final newState = updatedState ?? state;
    emit(
      (newState.copyWith(
        status: StateStatus.loading,
        error: ExternalError.none,
      ) as T),
    );
  }

  void emitSuccess([T? updatedState]) {
    final newState = updatedState ?? state;
    emit(
      (newState.copyWith(
        status: StateStatus.success,
        error: ExternalError.none,
      ) as T),
    );
  }

  void emitFailure([Object? error, StackTrace? stackTrace]) {
    emit(
      (state.copyWith(
        status: StateStatus.failure,
        error: GenericError(error),
      ) as T),
    );
  }

  @override
  void onChange(Change<T> change) {
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
