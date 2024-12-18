import 'package:equatable/equatable.dart';
import 'package:solar_monitoring_app/domain/models/solar_data_model.dart';

import '../../domain/common/error_handling/decoding_error.dart';

class SolarDataDto extends Equatable {
  final DateTime timestamp;
  final double value;

  const SolarDataDto({
    required this.timestamp,
    required this.value,
  });

  // Json parsing
  factory SolarDataDto.fromJson(Map<String, dynamic> json) => SolarDataDto(
        timestamp: DateTime.parse(json['timestamp']),
        value: json.toInt('value').toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(), // Convert DateTime to String
        'value': value.toInt(),
      };

  @override
  List<Object?> get props => [timestamp, value];
}

extension DomainModelExtension on SolarDataDto {
  SolarDataModel get toDomainModel => SolarDataModel(
        timestamp: timestamp,
        value: value,
      );
}

extension TypeCastExtension on Map<String, dynamic> {
  int toInt(String key) {
    try {
      return (this[key] as int);
    } on TypeError catch (error) {
      throw DecodingError(key, error.toString());
    }
  }
}
