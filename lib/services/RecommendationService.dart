
import 'dart:convert';
import 'package:clima_guard_mobile/dtos/RecommendationRequestDto.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class RecommendationService {
  final String ipAddress;
  final Logger logger;

  RecommendationService({
    required this.ipAddress,
    required this.logger
  });

  String get baseUrl => 'http://$ipAddress:5002/api/recommend';

  Future<List<DateTime>> fetchRecommendedTimes(RecommendationRequestDto request) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: request.toQueryParameters());

    logger.i('[RecommendationService] Fetching recommended times: $uri');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    logger.i('[RecommendationService] Status Code: ${response.statusCode}');
    logger.d('[RecommendationService] Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<DateTime>((str) => DateTime.parse(str)).toList();
    } else {
      logger.e('[RecommendationService] Failed to fetch recommended departure times');
      throw Exception('Failed to fetch recommended departure times');
    }
  }
}
