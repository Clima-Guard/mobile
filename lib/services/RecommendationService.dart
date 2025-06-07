
import 'dart:convert';
import 'package:clima_guard_mobile/dtos/RecommendationRequestDto.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/RecommendationDataModel.dart';

class RecommendationService {
  final String ipAddress;
  final Logger logger;

  RecommendationService({
    required this.ipAddress,
    required this.logger
  });

  String get baseUrl => 'http://$ipAddress:5002/api/recommend';

  Future<List<RecommendationDataModel>> fetchRecommendations(RecommendationRequestDto request) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: request.toQueryParameters());

    logger.i('[RecommendationService] Fetching full recommendation responses: $uri');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => RecommendationDataModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch recommendations');
    }
  }

}
