import 'package:solar_monitoring_app/data/services/cache_data_service.dart';
import 'package:solar_monitoring_app/domain/use_cases/clear_cache_use_case.dart';

import '../data/repositories/solar_data_repository.dart';
import '../data/services/api_service.dart';
import '../data/services/solar_data_service.dart';
import '../domain/use_cases/get_solar_data_use_case.dart';

// This serves as a dependency manager and a boundary between the presentation and the data layers
// Can be replaced by GetIt or any other package instead
abstract class SolarAppUseCases {
  static final _apiService = ApiService();
  static final _cacheDataService = CacheDataService();

  static final _solarDataService = SolarDataService(apiService: _apiService);
  static final _solarDataRepository = SolarDataRepository(
    solarDataService: _solarDataService,
    cacheDataService: _cacheDataService,
  );

  static GetSolarDataUseCase makeGetSolarDataUseCase() => GetSolarDataUseCase(solarDataRepo: _solarDataRepository);

  static ClearCacheUseCase makeClearCacheUseCase() => ClearCacheUseCase(solarDataRepo: _solarDataRepository);
}
