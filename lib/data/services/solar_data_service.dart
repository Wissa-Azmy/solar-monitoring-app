import 'package:http/http.dart';
import 'package:solar_monitoring_app/data/services/api_service.dart';
import 'package:solar_monitoring_app/domain/common/error_handling/external_error.dart';
import 'package:solar_monitoring_app/domain/common/extensions/string_extensions.dart';
import 'package:solar_monitoring_app/domain/models/monitoring_type.dart';

import '../../domain/common/error_handling/app_error.dart';
import '../DTOs/solar_data_dto.dart';
import '../common/api_resource.dart';

// I adopted this `*_protocol` naming convention from iOS/Swift development
// But, I am not willing to die for it.😀
abstract class SolarDataServiceProtocol {
  Future<List<SolarDataDto>> getSolarData({
    required MonitoringType type,
    required String date,
  });
}

class SolarDataService implements SolarDataServiceProtocol {
  final ApiServiceProtocol apiService;
  final ApiResource _resource = ApiResource.monitoring;

  SolarDataService({required this.apiService});

  @override
  Future<List<SolarDataDto>> getSolarData({
    required MonitoringType type,
    required String date,
  }) async {
    final parameters = {'type': type.name, 'date': date};
    final response = await apiService.sendGetRequest(_resource, parameters);
    final responseBody = response.body;

    if (response.statusCode == 200) {
      return _parseJsonToDtoList(responseBody);
    } else {
      return Future.error(_handleResponseError(response));
    }
  }

  AppError _handleResponseError(Response response) {
    if (response.statusCode == 500) {
      return ExternalError.serverError;
      // The same for all other codes....
    } else {
      logger.e('Server error: ${response.statusCode} - ${response.body}');
      final jsonResponseBody = response.body.toJson();
      // Custom errorCode that should be agreed on
      final errorCode = jsonResponseBody['errorCode'];
      return AppError.forCode(errorCode);
    }
  }

  List<SolarDataDto> _parseJsonToDtoList(String jsonString) {
    final List<dynamic> jsonData = jsonString.toJson();
    return jsonData.map((item) => SolarDataDto.fromJson(item)).toList();
  }
}
