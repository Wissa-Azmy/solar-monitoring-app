import 'package:solar_monitoring_app/domain/models/monitoring_type.dart';
import 'package:solar_monitoring_app/presentation/common/state_management/base_cubit.dart';
import 'package:solar_monitoring_app/presentation/common/states/solar_data_satate.dart';
import 'package:solar_monitoring_app/presentation_dependencies/solar_app_use_cases.dart';

import '../../../domain/use_cases/get_solar_data_use_case.dart';

class SolarDataCubit extends BaseCubit<SolarDataState> {
  final GetSolarDataUseCase getSolarDataUseCase;

  factory SolarDataCubit() => SolarDataCubit.withValues(
        SolarDataState(),
        getSolarDataUseCase: SolarAppUseCases.makeGetSolarDataUseCase(),
      );

  SolarDataCubit.withValues(super.state, {required this.getSolarDataUseCase});

  Future<void> getSolarData() async {
    emitLoading();

    try {
      final solarData = await getSolarDataUseCase.invoke(
        type: MonitoringType.solar,
        date: state.selectedDate,
      );

      final houseData = await getSolarDataUseCase.invoke(
        type: MonitoringType.house,
        date: state.selectedDate,
      );

      final batteryData = await getSolarDataUseCase.invoke(
        type: MonitoringType.battery,
        date: state.selectedDate,
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

  void selectDate(DateTime date) {
    emitPreviousState(state.copyWith(selectedDate: date));
    getSolarData();
  }

  void selectTab(int tabIndex) {
    emitPreviousState(state.copyWith(selectedTabIndex: tabIndex));
  }
}
