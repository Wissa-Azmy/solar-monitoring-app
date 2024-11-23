import 'package:solar_monitoring_app/domain/models/solar_data_model.dart';

import '../models/monitoring_type.dart';

abstract class SolarDataRepositoryProtocol {
  Future<List<SolarDataModel>> getSolarData({
    required MonitoringType type,
    required String date,
  });
}