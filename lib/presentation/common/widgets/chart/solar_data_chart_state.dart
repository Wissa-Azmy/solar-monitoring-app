import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../domain/common/error_handling/app_error.dart';
import '../../../../domain/models/solar_data_model.dart';
import '../../state_management/base_state.dart';

class SolarDataChartState extends BaseState {
  final List<SolarDataModel> chartData;
  final bool isShowingKiloWatts;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  List<FlSpot> get chartSpots => chartData.map((point) {
        double yValue = isShowingKiloWatts ? point.powerInKiloWatts : point.powerInWatts;
        double xValue = point.timestamp.millisecondsSinceEpoch.toDouble();
        return FlSpot(xValue, yValue);
      }).toList();

  Color get chartColor => chartData.last.powerInWatts > chartData.first.powerInWatts ? Colors.green : Colors.red;

  String get unitText => isShowingKiloWatts ? "kW" : "W";

  String get filterButtonText =>
      startTime == null || endTime == null ? "Select Time Range" : "Time: $_startTimeText - $_endTimeText";

  String get _startTimeText => '${startTime?.hour.toString()}:${startTime?.minute.toString()}';

  String get _endTimeText => '${endTime?.hour.toString()}:${endTime?.minute.toString()}';

  const SolarDataChartState({
    super.status,
    super.error,
    required this.chartData,
    this.startTime,
    this.endTime,
    this.isShowingKiloWatts = false,
  });

  @override
  SolarDataChartState copyWith({
    List<SolarDataModel>? chartData,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isShowingKiloWatts,
    StateStatus? status,
    AppError? error,
  }) =>
      SolarDataChartState(
        chartData: chartData ?? this.chartData,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        isShowingKiloWatts: isShowingKiloWatts ?? this.isShowingKiloWatts,
        status: status,
        error: error,
      );

  @override
  List<Object?> get props => super.props..addAll([chartData, startTime, endTime, isShowingKiloWatts]);

  @override
  String toString() => '''\n\t  { 
      solar data list: ${chartData.length}, 
      is showing kilo watts: $isShowingKiloWatts, 
      ${super.toString()}
    }''';
}
