
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'RouteDataModel.dart';

class RouteMergedData {
  final RouteDataModel routeData;
  final List<LatLng> interpolatedPoints;
  final DateTime recommendedLocalDepartureTime;
  final DateTime recommendedUtcDepartureTime;
  final List<Map<String, double>> weatherConditions;

  RouteMergedData({
    required this.routeData,
    required this.interpolatedPoints,
    required this.recommendedLocalDepartureTime,
    required this.recommendedUtcDepartureTime,
    required this.weatherConditions,
  });
}
