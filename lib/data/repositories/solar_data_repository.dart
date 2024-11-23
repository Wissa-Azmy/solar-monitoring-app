import 'package:solar_monitoring_app/data/DTOs/solar_data_dto.dart';
import 'package:solar_monitoring_app/domain/models/monitoring_type.dart';
import 'package:solar_monitoring_app/domain/models/solar_data_model.dart';

import '../../domain/data_service_protocols/solar_data_service_protocol.dart';
import '../../domain/repositories_protocols/solar_data_repository_protocol.dart';

class SolarDataRepository implements SolarDataRepositoryProtocol {
  final SolarDataServiceProtocol solarDataService;

  SolarDataRepository({required this.solarDataService});

  @override
  Future<List<SolarDataModel>> getSolarData({
    required MonitoringType type,
    required String date,
  }) =>
      solarDataService
          .getSolarData(type: type, date: date)
          .then((dtos) => dtos.map((dto) => dto.toDomainModel).toList());
}
