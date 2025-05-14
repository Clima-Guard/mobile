
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/PolylineDecoder.dart';

class RouteDataModel {
  final int distanceMeters;
  final Duration duration;
  final String encodedPolyline;
  late final List<LatLng> decodedPolyline;

  RouteDataModel({
    required this.distanceMeters,
    required this.duration,
    required this.encodedPolyline,
  }) {
    decodedPolyline = PolylineDecoder.decode(encodedPolyline);
  }

  factory RouteDataModel.fromJson(Map<String, dynamic> json) {
    return RouteDataModel(
      distanceMeters: json['distanceMeters'],
      duration: Duration(seconds: json['duration']),
      encodedPolyline: json['polyline'],
    );
  }
}
