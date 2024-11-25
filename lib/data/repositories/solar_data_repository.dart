import 'package:solar_monitoring_app/data/DTOs/solar_data_dto.dart';
import 'package:solar_monitoring_app/data/services/cache_data_service.dart';
import 'package:solar_monitoring_app/domain/models/monitoring_type.dart';
import 'package:solar_monitoring_app/domain/models/solar_data_model.dart';

import '../../domain/repositories_protocols/solar_data_repository_protocol.dart';
import '../services/solar_data_service.dart';

class SolarDataRepository implements SolarDataRepositoryProtocol {
  final SolarDataServiceProtocol solarDataService;
  final CacheDataServiceProtocol cacheDataService;

  SolarDataRepository({required this.cacheDataService, required this.solarDataService});

  @override
  Future<List<SolarDataModel>> getSolarData({
    required MonitoringType type,
    required String date,
    required bool useCache,
  }) async {
    final cachingKey = '${type.name} $date';
    if (useCache) {
      final cachedDtos = await cacheDataService.getData(cachingKey);
      if (cachedDtos != null) {
        final cachedData = cachedDtos.map((dto) => dto.toDomainModel).toList();
        return cachedData;
      }
    }

    final liveDataDtos = await solarDataService.getSolarData(type: type, date: date);
    await cacheDataService.saveData(cachingKey, liveDataDtos);

    final liveData = liveDataDtos.map((dto) => dto.toDomainModel).toList();
    return liveData;
  }

  @override
  Future<void> clearCache() async {
    await cacheDataService.clearAll();
  }
}
