

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineDecoder {
  /// Decodes an encoded polyline string into a list of LatLng points.
  static List<LatLng> decode(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPoints = polylinePoints.decodePolyline(encodedPolyline);

    return decodedPoints
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
  }
}