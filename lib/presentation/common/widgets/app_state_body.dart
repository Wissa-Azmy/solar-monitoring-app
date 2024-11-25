import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring_app/presentation/common/design/app_size.dart';

import '../state_management/base_state.dart';

class AppStateBody<Y extends StateStreamable<T>, T extends BaseState> extends StatelessWidget {
  final Widget body;

  const AppStateBody({super.key, required this.body});

  @override
  Widget build(BuildContext context) => BlocBuilder<Y, T>(
        builder: (context, state) => switch (state.status) {
          StateStatus.loading => const Center(child: CircularProgressIndicator()),
          StateStatus.success => body,
          StateStatus.empty => const Center(child: Text('No Data')),
          StateStatus.failure => ErrorView(error: state.error.localizedDescription),
        },
      );
}

class ErrorView extends StatelessWidget {
  final String error;

  const ErrorView({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppSize.expandedSpace,
            const Text('Something wrong happened!'),
            Text(error),
            AppSize.expandedSpace,
          ],
        ),
      );
}
