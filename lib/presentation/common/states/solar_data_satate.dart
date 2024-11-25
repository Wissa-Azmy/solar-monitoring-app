import 'package:solar_monitoring_app/domain/common/extensions/date_time_extensions.dart';
import 'package:solar_monitoring_app/domain/models/solar_data_model.dart';
import 'package:solar_monitoring_app/presentation/common/state_management/base_state.dart';

import '../../../domain/common/error_handling/app_error.dart';

class SolarDataState extends BaseState {
  final List<SolarDataModel> solarMonitoringData;
  final List<SolarDataModel> houseMonitoringData;
  final List<SolarDataModel> batteryMonitoringData;
  final DateTime selectedDate;
  final int selectedTabIndex;

  final pickerMinimumDate = DateTimeExtension.yearFromNow;
  final DateTime pickerMaxDate = DateTime.now();

  SolarDataState({
    super.status,
    super.error,
    this.solarMonitoringData = const [],
    this.houseMonitoringData = const [],
    this.batteryMonitoringData = const [],
    DateTime? selectedDate,
    this.selectedTabIndex = 0,
  }) : selectedDate = selectedDate ?? DateTime.now();

  @override
  SolarDataState copyWith({
    List<SolarDataModel>? solarMonitoringData,
    List<SolarDataModel>? houseMonitoringData,
    List<SolarDataModel>? batteryMonitoringData,
    DateTime? selectedDate,
    int? selectedTabIndex,
    StateStatus? status,
    AppError? error,
  }) =>
      SolarDataState(
        solarMonitoringData: solarMonitoringData ?? this.solarMonitoringData,
        houseMonitoringData: houseMonitoringData ?? this.houseMonitoringData,
        batteryMonitoringData: batteryMonitoringData ?? this.batteryMonitoringData,
        selectedDate: selectedDate ?? this.selectedDate,
        selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
        status: status,
        error: error,
      );

  @override
  List<Object?> get props => super.props
    ..addAll([
      solarMonitoringData,
      houseMonitoringData,
      batteryMonitoringData,
      selectedDate,
      selectedTabIndex,
    ]);

  @override
  String toString() => '''\n\t  { 
      selected date: $selectedDate,
      solar data list count: ${solarMonitoringData.length}, 
      house data list count: ${houseMonitoringData.length}, 
      batter data list count: ${batteryMonitoringData.length}, 
      ${super.toString()}
    }''';
}
