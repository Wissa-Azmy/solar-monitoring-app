import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring_app/presentation/common/design/app_theme.dart';
import 'package:solar_monitoring_app/presentation/common/extensions/context_extensions.dart';
import 'package:solar_monitoring_app/presentation/common/state_management/base_state.dart';
import 'package:solar_monitoring_app/presentation/common/states/solar_data_cubit.dart';
import 'package:solar_monitoring_app/presentation/common/states/solar_data_satate.dart';
import 'package:solar_monitoring_app/presentation/common/widgets/chart/solar_data_chart.dart';

class MonitoringTabController extends StatelessWidget {
  const MonitoringTabController({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => SolarDataCubit()..getSolarData(),
        child: BlocConsumer<SolarDataCubit, SolarDataState>(
          listener: (context, state) {},
          builder: (context, state) => DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Solar Monitoring',
                  style: context.font.titleLarge?.semiBold.copyWith(
                    color: context.color.onPrimary,
                  ),
                ),
                backgroundColor: context.color.primary,
              ),
              body: switch (state.status) {
                StateStatus.loading => const Center(child: CircularProgressIndicator()),
                StateStatus.success => Column(
                    children: [
                      // Move TabBar to the body
                      Material(
                        color: context.color.primary, // Background color for tabs
                        child: TabBar(
                          isScrollable: true,
                          labelColor: context.color.onPrimary,
                          tabs: const [
                            Tab(text: 'Solar Generation'),
                            Tab(text: 'House Consumption'),
                            Tab(text: 'Battery Consumption'),
                          ],
                        ),
                      ),
                      // TabBarView for tab content
                      Expanded(
                        child: TabBarView(
                          children: [
                            SolarDataChart(data: state.solarMonitoringData),
                            SolarDataChart(data: state.houseMonitoringData),
                            SolarDataChart(data: state.batteryMonitoringData),
                          ],
                        ),
                      ),
                    ],
                  ),
                StateStatus.empty => const Center(child: Text('No Data')),
                StateStatus.failure => Center(
                    child: Text('Something wrong happened!\n${state.error.localizedDescription}'),
                  ),
              },
            ),
          ),
        ),
      );
}
