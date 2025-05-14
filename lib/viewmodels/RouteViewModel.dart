
import 'package:clima_guard_mobile/dtos/RecommendationRequestDto.dart';
import 'package:clima_guard_mobile/models/RouteMergedData.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../dtos/RouteRequestDto.dart';
import '../dtos/WeatherRequestDto.dart';
import '../services/RouteService.dart';
import '../services/WeatherService.dart';
import '../services/RecommendationService.dart';

class RouteViewModel extends ChangeNotifier {
  final RouteService routeService;
  final WeatherService weatherService;
  final RecommendationService recommendationService;
  final Logger logger;

  RouteViewModel({
    required this.routeService,
    required this.weatherService,
    required this.recommendationService,
    required this.logger
  });

  List<RouteMergedData> fullRoutes = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> loadFullRouteData({
    required String origin,
    required String destination,
    required List<String> waypoints,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      logger.i('[RouteViewModel] Starting loadFullRouteData...');

      final request = RouteRequestDto(
        origin: origin,
        destination: destination,
        waypoints: waypoints,
      );

      logger.i('[RouteViewModel] Fetching routes and interpolated points...');
      final fetchedRoutes = await routeService.fetchRoutes(request);
      final fetchedInterpolatedPoints = await routeService.fetchInterpolatedPoints(request);

      logger.i('[RouteViewModel] Preparing weather request...');
      final coordinates = fetchedInterpolatedPoints.map((route) {
        return route.map((latLng) => Coordinate(lat: latLng.latitude, lng: latLng.longitude)).toList();
      }).toList();

      final weatherRequest = WeatherRequestDto(
        coordinates: coordinates,
        startDate: startDate,
        endDate: endDate,
      );

      logger.i('[RouteViewModel] Fetching S3 key...');
      final s3Key = await weatherService.fetchS3Key(weatherRequest);

      final recommendationRequest = RecommendationRequestDto(key: s3Key);

      logger.i('[RouteViewModel] Fetching recommended departure times...');
      final fetchedRecommendedTimes = await recommendationService.fetchRecommendedTimes(recommendationRequest);

      logger.i('[RouteViewModel] Successfully loaded full route data.');

      fullRoutes = List.generate(fetchedRoutes.length, (index) {
        return RouteMergedData(
          routeData: fetchedRoutes[index],
          interpolatedPoints: fetchedInterpolatedPoints[index],
          recommendedDepartureTime: fetchedRecommendedTimes[index],
        );
      });
    } catch (e, stackTrace) {
      logger.e('[RouteViewModel] Error in loadFullRouteData', error: e, stackTrace: stackTrace);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
