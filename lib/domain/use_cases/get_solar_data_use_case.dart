import 'package:solar_monitoring_app/domain/models/solar_data_model.dart';
import 'package:solar_monitoring_app/domain/repositories_protocols/solar_data_repository_protocol.dart';

import '../models/monitoring_type.dart';

// The use case does not implement a protocol because I believe it should not be mocked
// As it is also not replaceable
class GetSolarDataUseCase {
  final SolarDataRepositoryProtocol solarDataRepo;

  GetSolarDataUseCase({required this.solarDataRepo});

  Future<List<SolarDataModel>> invoke({
    required MonitoringType type,
    required String date,
  }) async =>
      await solarDataRepo.getSolarData(type: type, date: date);
}
