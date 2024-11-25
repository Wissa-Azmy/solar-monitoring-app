import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring_app/domain/models/solar_data_model.dart';
import 'package:solar_monitoring_app/presentation/common/design/app_size.dart';
import 'package:solar_monitoring_app/presentation/common/widgets/chart/solar_data_chart_state.dart';
import 'package:solar_monitoring_app/presentation/common/widgets/chart/solart_data_chart_cubit.dart';

import '../text_label.dart';

class SolarDataChart extends StatelessWidget {
  final List<SolarDataModel> data;

  const SolarDataChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => SolarDataChartCubit(data),
        child: BlocBuilder<SolarDataChartCubit, SolarDataChartState>(
          builder: (context, state) => Padding(
            padding: AppSize.small.hPadding,
            child: state.isEmpty
                ? const TextLabel('No Data')
                : Column(
                    children: [
                      AppSize.medium.vSpace,
                      const DataChart(),
                      AppSize.medium.vSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const UnitSwitchButton(),
                          AppSize.medium.hSpace,
                          const FilterButton(),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      );
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SolarDataChartCubit, SolarDataChartState>(
        builder: (context, state) => ElevatedButton(
          onPressed: () => _selectTimeRange(
            context,
            startTime: state.startTime,
            endTime: state.endTime,
          ),
          child: TextLabel(state.filterButtonText),
        ),
      );

  Future<void> _selectTimeRange(BuildContext context, {required TimeOfDay? startTime, TimeOfDay? endTime}) async {
    TimeOfDay? start = await showTimePicker(
      context: context,
      initialTime: startTime ?? const TimeOfDay(hour: 0, minute: 0),
    );

    if (start != null && context.mounted) {
      TimeOfDay? end = await showTimePicker(
        context: context,
        initialTime: endTime ?? const TimeOfDay(hour: 23, minute: 59),
      );

      if (end != null && context.mounted) {
        context.read<SolarDataChartCubit>().filterData(start, end);
      }
    }
  }
}

class DataChart extends StatelessWidget {
  const DataChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<SolarDataChartCubit, SolarDataChartState>(
        builder: (context, state) => SizedBox(
          height: 300,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: state.chartSpots,
                  color: state.chartColor,
                  dotData: const FlDotData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: AppSize.xLarge,
                    interval: state.isShowingKiloWatts ? 1 : 1000,
                    getTitlesWidget: (value, meta) => TextLabel(
                      "${value.toStringAsFixed(0)} ${state.unitText}",
                      style: const TextStyle(fontSize: AppSize.xSmall),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                      return TextLabel(
                        "${date.hour}:${date.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: AppSize.xSmall),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              // gridData: FlGridData(show: true),
            ),
          ),
        ),
      );
}

class UnitSwitchButton extends StatelessWidget {
  const UnitSwitchButton({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SolarDataChartCubit, SolarDataChartState>(
        builder: (context, state) => SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextLabel("Watts"),
              Switch(
                value: state.isShowingKiloWatts,
                onChanged: context.read<SolarDataChartCubit>().toggleIsShowingKiloWatts,
              ),
              const TextLabel("KW"),
            ],
          ),
        ),
      );
}
