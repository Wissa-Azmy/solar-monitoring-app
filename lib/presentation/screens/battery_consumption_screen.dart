import 'package:flutter/material.dart';

import '../../domain/models/solar_data_model.dart';
import '../common/widgets/chart/solar_data_chart.dart';

class BatteryConsumptionScreen extends StatelessWidget {
  final List<SolarDataModel> data;

  const BatteryConsumptionScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) => SolarDataChart(data: data);
}
