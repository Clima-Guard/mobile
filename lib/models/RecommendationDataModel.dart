
class RecommendationDataModel {
  final DateTime recommendedLocalDepartureDateTime;
  final DateTime recommendedUtcDepartureDateTime;
  final List<Map<String, double>> weatherConditionsForDepartureDateTime;

  RecommendationDataModel({
    required this.recommendedLocalDepartureDateTime,
    required this.recommendedUtcDepartureDateTime,
    required this.weatherConditionsForDepartureDateTime,
  });

  factory RecommendationDataModel.fromJson(Map<String, dynamic> json) {
    return RecommendationDataModel(
      recommendedLocalDepartureDateTime: DateTime.parse(json['recommendedLocalDepartureDateTime']),
      recommendedUtcDepartureDateTime: DateTime.parse(json['recommendedUtcDepartureDateTime']),
      weatherConditionsForDepartureDateTime: (json['weatherConditionsForDepartureDateTime'] as List)
          .map<Map<String, double>>((item) =>
          (item as Map<String, dynamic>).map<String, double>(
                  (key, value) => MapEntry(key, (value as num).toDouble())))
          .toList(),
    );
  }
}