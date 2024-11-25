enum Strings { of }

extension CommonStringsExtension on Strings {
  MainScreens get mainScreens => MainScreens();
}

class MainScreens {
  // TABS Strings
  final solarGenerationTabName = 'Solar';
  final houseConsumptionTabName = 'House';
  final batteryConsumptionTabName = 'Battery';

  final solarGenerationScreenTitle = 'Solar Generation';
  final houseConsumptionScreenTitle = 'House Consumption';
  final batteryConsumptionScreenTitle = 'Battery Consumption';
}
