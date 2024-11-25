import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring_app/domain/common/extensions/date_time_extensions.dart';
import 'package:solar_monitoring_app/presentation/common/design/app_size.dart';
import 'package:solar_monitoring_app/presentation/common/strings/strings.dart';
import 'package:solar_monitoring_app/presentation/common/widgets/app_state_body.dart';
import 'package:solar_monitoring_app/presentation/common/widgets/solar_app_bar.dart';
import 'package:solar_monitoring_app/presentation/screens/battery_consumption_screen.dart';
import 'package:solar_monitoring_app/presentation/screens/house_consumption_screen.dart';
import 'package:solar_monitoring_app/presentation/screens/solar_generation_screen.dart';

import '../common/states/solar_data_cubit.dart';
import '../common/states/solar_data_satate.dart';
import '../common/widgets/text_label.dart';

class TabBarController extends StatelessWidget {
  TabBarController({super.key});

  Widget screenFor(SolarDataState state) {
    final List<Widget> screens = [
      SolarGenerationScreen(data: state.solarMonitoringData),
      HouseConsumptionScreen(data: state.houseMonitoringData),
      BatteryConsumptionScreen(data: state.batteryMonitoringData),
    ];

    return screens[state.selectedTabIndex];
  }

  final List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(
      label: Strings.of.mainScreens.solarGenerationTabName,
      icon: const Icon(Icons.light_mode_rounded),
    ),
    BottomNavigationBarItem(
      label: Strings.of.mainScreens.houseConsumptionTabName,
      icon: const Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: Strings.of.mainScreens.batteryConsumptionTabName,
      icon: const Icon(Icons.battery_saver_rounded),
    ),
  ];

  final List<String> _appBarTitles = [
    Strings.of.mainScreens.solarGenerationScreenTitle,
    Strings.of.mainScreens.houseConsumptionScreenTitle,
    Strings.of.mainScreens.batteryConsumptionScreenTitle,
  ];

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => SolarDataCubit()..getSolarData(),
        child: BlocBuilder<SolarDataCubit, SolarDataState>(
          builder: (context, state) => Scaffold(
            appBar: SolarAppBar(title: _appBarTitles[state.selectedTabIndex]),
            bottomNavigationBar: BottomNavigationBar(
              items: _barItems,
              onTap: context.read<SolarDataCubit>().selectTab,
              currentIndex: state.selectedTabIndex,
            ),
            body: AppStateBody<SolarDataCubit, SolarDataState>(
              onRefresh: () => context.read<SolarDataCubit>().getSolarData(isReloading: true),
              body: Column(
                children: [
                  AppSize.medium.vSpace,
                  const FilterButton(),
                  screenFor(state),
                  AppSize.medium.vSpace,
                  ElevatedButton(
                    onPressed: context.read<SolarDataCubit>().clearCache,
                    child: const TextLabel('Clear Cache'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SolarDataCubit, SolarDataState>(
        builder: (context, state) => ElevatedButton(
          onPressed: () => _selectTimeRange(
            context,
            firstDate: state.pickerMinimumDate,
            lastDate: state.pickerMaxDate,
          ),
          child: TextLabel(state.selectedDate.stringDate),
        ),
      );

  Future<void> _selectTimeRange(
    BuildContext context, {
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: lastDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null && context.mounted) {
      context.read<SolarDataCubit>().selectDate(selectedDate);
    }
  }
}
