class SolarDataModel {
  final DateTime timestamp;
  final double powerInWatts;

  double get powerInKiloWatts => powerInWatts / 1000;

  SolarDataModel({
    required this.timestamp,
    required this.powerInWatts,
  });
}