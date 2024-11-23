class SolarDataModel {
  final DateTime dateTime;
  final double powerInWatts;

  double get powerInKiloWatts => powerInWatts / 1000;

  SolarDataModel({
    required this.dateTime,
    required this.powerInWatts,
  });
}