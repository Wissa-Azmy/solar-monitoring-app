import 'package:solar_monitoring_app/domain/models/solar_data_model.dart';
import 'package:solar_monitoring_app/presentation/common/state_management/base_state.dart';

import '../../../domain/common/error_handling/app_error.dart';

class SolarDataState extends BaseState {
  final List<SolarDataModel> solarMonitoringData;
  final List<SolarDataModel> houseMonitoringData;
  final List<SolarDataModel> batteryMonitoringData;

  const SolarDataState({
    super.status,
    super.error,
    this.solarMonitoringData = const [],
    this.houseMonitoringData = const [],
    this.batteryMonitoringData = const [],
  });

  @override
  SolarDataState copyWith({
    List<SolarDataModel>? solarMonitoringData,
    List<SolarDataModel>? houseMonitoringData,
    List<SolarDataModel>? batteryMonitoringData,
    StateStatus? status,
    AppError? error,
  }) =>
      SolarDataState(
        solarMonitoringData: solarMonitoringData ?? this.solarMonitoringData,
        houseMonitoringData: houseMonitoringData ?? this.houseMonitoringData,
        batteryMonitoringData:
            batteryMonitoringData ?? this.batteryMonitoringData,
        status: status,
        error: error,
      );

  @override
  List<Object?> get props => super.props
    ..addAll([
      solarMonitoringData,
      houseMonitoringData,
      batteryMonitoringData,
    ]);


  @override
  String toString()=> '''\n\t  { 
      solar data list: ${solarMonitoringData.length}, 
      house data list: ${houseMonitoringData.length}, 
      batter data list: ${batteryMonitoringData.length}, 
      ${super.toString()}
    }''';
}
