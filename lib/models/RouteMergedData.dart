
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'RouteDataModel.dart';

class RouteMergedData {
  final RouteDataModel routeData;
  final List<LatLng> interpolatedPoints;
  final DateTime recommendedDepartureTime;

  RouteMergedData({
    required this.routeData,
    required this.interpolatedPoints,
    required this.recommendedDepartureTime,
  });
}
