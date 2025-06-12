
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../dtos/RouteRequestDto.dart';
import '../models/RouteDataModel.dart';

class RouteService {
  final String urlPath;
  final Logger logger;

  RouteService({
    required this.urlPath,
    required this.logger
  });

  String get baseUrl => '$urlPath/api/routes';

  Future<List<RouteDataModel>> fetchRoutes(RouteRequestDto request) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: request.toQueryParameters());

    logger.i('[RouteService] Fetching routes: $uri');

    final response = await http.get(uri);

    logger.i('[RouteService] Status Code: ${response.statusCode}');
    logger.d('[RouteService] Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => RouteDataModel.fromJson(json)).toList();
    } else {
      logger.e('[RouteService] Failed to fetch routes');
      throw Exception('Failed to fetch routes');
    }
  }

  Future<List<List<LatLng>>> fetchInterpolatedPoints(RouteRequestDto request) async {
    final uri = Uri.parse('$baseUrl/interpolation').replace(queryParameters: request.toQueryParameters());

    logger.i('[RouteService] Fetching interpolated points: $uri');

    final response = await http.get(uri);

    logger.i('[RouteService] Status Code: ${response.statusCode}');
    logger.d('[RouteService] Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<List<LatLng>>((routePoints) {
        return (routePoints as List).map((point) {
          return LatLng(point['latitude'], point['longitude']);
        }).toList();
      }).toList();
    } else {
      logger.e('[RouteService] Failed to fetch interpolated points');
      throw Exception('Failed to fetch interpolated points');
    }
  }
}
