import '../data/repositories/solar_data_repository.dart';
import '../data/services/api_service.dart';
import '../data/services/solar_data_service.dart';
import '../domain/repositories_protocols/solar_data_repository_protocol.dart';
import '../domain/use_cases/get_solar_data_use_case.dart';

// This serves as a boundary between the presentation and the data layers
// Can be moved to an app module if exists
class SolarDataCubitUseCases {
  final GetSolarDataUseCase getSolarData;

  SolarDataCubitUseCases()
      : getSolarData = GetSolarDataUseCase(solarDataRepo: _makeRepo());

  SolarDataCubitUseCases.withDependencies({required this.getSolarData});

  static SolarDataRepositoryProtocol _makeRepo() {
    final solarDataService = SolarDataService(apiService: ApiService());
    return SolarDataRepository(solarDataService: solarDataService);
  }
}
