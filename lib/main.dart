import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring_app/presentation/common/design/app_theme.dart';
import 'package:solar_monitoring_app/presentation/common/extensions/context_extensions.dart';
import 'package:solar_monitoring_app/presentation/common/state_management/app_bloc_observer.dart';
import 'package:solar_monitoring_app/presentation/common/states/solar_data_cubit.dart';
import 'package:solar_monitoring_app/presentation/common/states/solar_data_satate.dart';
import 'package:solar_monitoring_app/presentation_dependencies/solar_data_cubit_use_cases.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  final solarDataUseCases = SolarDataCubitUseCases();
  const solarDataState = SolarDataState();
  final cubit = SolarDataCubit(solarDataState, useCases: solarDataUseCases);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar Monitoring',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: context.font.bodySmall?.semiBold,
            ),
            Text(
              '$_counter',
              style: context.font.bodyLarge?.bold,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
