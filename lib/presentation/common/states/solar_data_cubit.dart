import 'package:solar_monitoring_app/domain/models/monitoring_type.dart';
import 'package:solar_monitoring_app/presentation/common/state_management/base_cubit.dart';
import 'package:solar_monitoring_app/presentation/common/states/solar_data_satate.dart';
import 'package:solar_monitoring_app/presentation_dependencies/solar_data_cubit_use_cases.dart';

class SolarDataCubit extends BaseCubit<SolarDataState> {
  final SolarDataCubitUseCases useCases;

  factory SolarDataCubit() => SolarDataCubit.withValues(
        const SolarDataState(),
        useCases: SolarDataCubitUseCases(),
      );

  SolarDataCubit.withValues(super.state, {required this.useCases});

  Future<void> getSolarData() async {
    emitLoading();

    try {
      final solarData = await useCases.getSolarData.invoke(
        type: MonitoringType.solar,
        date: '2024.10.24',
      );

      final houseData = await useCases.getSolarData.invoke(
        type: MonitoringType.house,
        date: '2024.10.24',
      );

      final batteryData = await useCases.getSolarData.invoke(
        type: MonitoringType.battery,
        date: '2024.10.24',
      );

      emitSuccess(state.copyWith(
        solarMonitoringData: solarData,
        houseMonitoringData: houseData,
        batteryMonitoringData: batteryData,
      ));
    } catch (error) {
      emitFailure(error);
    }
  }
}
