import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/common/error_handling/app_error.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);

    logger.d('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    logger.d('${bloc.runtimeType} \n$error \n$stackTrace');
  }
}