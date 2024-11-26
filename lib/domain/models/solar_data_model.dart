import 'package:equatable/equatable.dart';

class SolarDataModel extends Equatable {
  final DateTime timestamp;
  final double value;

  double get valueInKiloWatts => value / 1000;

  const SolarDataModel({
    required this.timestamp,
    required this.value,
  });

  @override
  List<Object?> get props => [timestamp, value];
}