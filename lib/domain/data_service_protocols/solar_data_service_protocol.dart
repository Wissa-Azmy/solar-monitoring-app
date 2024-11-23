import 'package:solar_monitoring_app/data/DTOs/solar_data_dto.dart';
import 'package:solar_monitoring_app/domain/models/monitoring_type.dart';

// I adopted this `*_protocol` naming convention from iOS/Swift development
// But, I am not willing to die for it.😀
abstract class SolarDataServiceProtocol {
  Future<List<SolarDataDto>> getSolarData({
    required MonitoringType type,
    required String date,
  });
}
