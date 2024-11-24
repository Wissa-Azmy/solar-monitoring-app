import 'package:flutter/material.dart';
import 'package:solar_monitoring_app/presentation/common/state_management/base_state.dart';
import 'package:solar_monitoring_app/presentation/common/widgets/chart/solar_data_chart_state.dart';

import '../../../../domain/models/solar_data_model.dart';
import '../../state_management/base_cubit.dart';

class SolarDataChartCubit extends BaseCubit<SolarDataChartState> {
  factory SolarDataChartCubit(List<SolarDataModel> data) => SolarDataChartCubit.withValues(
        SolarDataChartState(chartData: data, status: data.isEmpty ? StateStatus.empty : StateStatus.success),
      );

  SolarDataChartCubit.withValues(super.state);

  Future<void> toggleIsShowingKiloWatts(bool value) async {
    emitSuccess(state.copyWith(isShowingKiloWatts: !state.isShowingKiloWatts));
  }

  // TODO: This should be moved to a use case
  Future<void> filterData(TimeOfDay? startTime, TimeOfDay? endTime) async {
    final filteredData = state.chartData.where((point) {
      if (startTime == null || endTime == null) {
        return true;
      }
      final time = TimeOfDay.fromDateTime(point.timestamp);
      final isAfterStart =
          startTime.hour < time.hour || (startTime.hour == time.hour && startTime.minute <= time.minute);
      final isBeforeEnd = endTime.hour > time.hour || (endTime.hour == time.hour && endTime.minute >= time.minute);
      return isAfterStart && isBeforeEnd;
    }).toList();

    emitSuccess(state.copyWith(chartData: filteredData, startTime: startTime, endTime: endTime));
  }
}
