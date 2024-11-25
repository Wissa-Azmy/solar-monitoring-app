import 'package:solar_monitoring_app/domain/repositories_protocols/solar_data_repository_protocol.dart';

class ClearCacheUseCase {
  final SolarDataRepositoryProtocol solarDataRepo;

  ClearCacheUseCase({required this.solarDataRepo});

  Future<void> invoke() async => await solarDataRepo.clearCache();
}
