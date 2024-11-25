import '../data/repositories/solar_data_repository.dart';
import '../data/services/api_service.dart';
import '../data/services/solar_data_service.dart';
import '../domain/use_cases/get_solar_data_use_case.dart';

// This serves as a dependency manager and a boundary between the presentation and the data layers
// Can be replaced by GetIt or any other package instead
class SolarAppUseCases {
  static GetSolarDataUseCase makeGetSolarDataUseCase() {
    final solarDataService = SolarDataService(apiService: ApiService());
    final repo = SolarDataRepository(solarDataService: solarDataService);
    return GetSolarDataUseCase(solarDataRepo: repo);
  }
}
