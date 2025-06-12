import 'package:clima_guard_mobile/CustomTheme.dart';
import 'package:clima_guard_mobile/services/RecommendationService.dart';
import 'package:clima_guard_mobile/services/RouteService.dart';
import 'package:clima_guard_mobile/services/WeatherService.dart';
import 'package:clima_guard_mobile/viewmodels/RouteViewModel.dart';
import 'package:clima_guard_mobile/views/RouteInputScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  String routeServicePath = dotenv.env['ROUTE_SERVICE_PATH']!;
  String weatherServicePath = dotenv.env['WEATHER_SERVICE_PATH']!;
  String recommendationServicePath = dotenv.env['RECOMMENDATION_SERVICE_PATH']!;
  Logger logger = Logger();

  final RouteService routeService = RouteService(urlPath: routeServicePath, logger: logger);
  final WeatherService weatherService = WeatherService(urlPath: weatherServicePath, logger: logger);
  final RecommendationService recommendationService = RecommendationService(urlPath: recommendationServicePath, logger: logger);
  final RouteViewModel viewModel = RouteViewModel(
      routeService: routeService,
      weatherService: weatherService,
      recommendationService: recommendationService,
      logger: logger
  );

  runApp(MyApp(viewModel: viewModel));
}

class MyApp extends StatelessWidget {
  final RouteViewModel viewModel;

  const MyApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClimaGuard',
      themeMode: ThemeMode.system,
      theme: CustomTheme.lightThemeData(),
      darkTheme: CustomTheme.darkThemeData(),
      home: RouteInputScreen(viewModel: viewModel),
    );
  }
}
