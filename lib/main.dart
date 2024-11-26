import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring_app/presentation/common/design/app_theme.dart';
import 'package:solar_monitoring_app/presentation/common/state_management/app_bloc_observer.dart';
import 'package:solar_monitoring_app/presentation/screens/tab_bar_controller/tab_bar_controller.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Solar Monitoring',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const SolarMonitoringApp(),
    );
}

class SolarMonitoringApp extends StatelessWidget {
  const SolarMonitoringApp({super.key});

  @override
  Widget build(BuildContext context) => TabBarController();
}
