import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring_app/presentation/common/design/app_size.dart';
import 'package:solar_monitoring_app/presentation/common/extensions/context_extensions.dart';
import 'package:solar_monitoring_app/presentation/common/widgets/text_label.dart';

import '../state_management/base_state.dart';

class AppStateBody<Y extends StateStreamable<T>, T extends BaseState> extends StatelessWidget {
  final Widget body;
  final Future<void> Function() onRefresh;

  const AppStateBody({super.key, required this.body, required this.onRefresh});

  @override
  Widget build(BuildContext context) => BlocBuilder<Y, T>(
        builder: (context, state) => RefreshIndicator(
          onRefresh: onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: switch (state.status) {
                  StateStatus.loading => const Center(child: CircularProgressIndicator()),
                  StateStatus.success => body,
                  StateStatus.empty => const Center(child: TextLabel('No Data')),
                  StateStatus.failure => ErrorView(error: state.error.localizedDescription),
                },
              ),
            ],
          ),
        ),
      );
}

class ErrorView extends StatelessWidget {
  final String error;

  const ErrorView({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: context.screenHeight - 250, // 250 for TabBar + NavBar height (est.) ,
        child: Padding(
          padding: AppSize.small.padding,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSize.expandedSpace,
                const TextLabel('Something wrong happened!'),
                TextLabel(error),
                AppSize.expandedSpace,
              ],
            ),
          ),
        ),
      );
}
