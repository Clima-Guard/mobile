
class RecommendationDataModel {
  final DateTime recommendedDepartureDateTime;
  final List<Map<String, double>> weatherConditionsForDepartureDateTime;

  RecommendationDataModel({
    required this.recommendedDepartureDateTime,
    required this.weatherConditionsForDepartureDateTime,
  });

  factory RecommendationDataModel.fromJson(Map<String, dynamic> json) {
    return RecommendationDataModel(
      recommendedDepartureDateTime: DateTime.parse(json['recommendedDepartureDateTime']),
      weatherConditionsForDepartureDateTime: (json['weatherConditionsForDepartureDateTime'] as List)
          .map<Map<String, double>>((item) =>
          (item as Map<String, dynamic>).map<String, double>(
                  (key, value) => MapEntry(key, (value as num).toDouble())))
          .toList(),
    );
  }
}