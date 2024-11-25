import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring_app/presentation/common/widgets/text_label.dart';

import '../state_management/base_state.dart';
import 'centered_column.dart';
import 'chart/error_view.dart';

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
                  StateStatus.loading => const CenteredColumn(children: [CircularProgressIndicator()]),
                  StateStatus.success => body,
                  StateStatus.empty => const CenteredColumn(children: [TextLabel('No Data')]),
                  StateStatus.failure => ErrorView(error: state.error.localizedDescription),
                },
              ),
            ],
          ),
        ),
      );
}
