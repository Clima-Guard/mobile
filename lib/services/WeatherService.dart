
import 'dart:convert';
import 'package:clima_guard_mobile/dtos/WeatherRequestDto.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class WeatherService {
  final String urlPath;
  final Logger logger;

  WeatherService({
    required this.urlPath,
    required this.logger
  });

  String get baseUrl => '$urlPath/api/weather/compress';

  Future<String> fetchS3Key(WeatherRequestDto request) async {
    final uri = Uri.parse(baseUrl);

    logger.i('[WeatherService] Requesting compressed weather data at: $uri');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    logger.i('[WeatherService] Status Code: ${response.statusCode}');
    logger.d('[WeatherService] Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return response.body.replaceAll('"', '');
    } else {
      logger.e('[WeatherService] Failed to fetch S3 key');
      throw Exception('Failed to fetch S3 key');
    }
  }
}
