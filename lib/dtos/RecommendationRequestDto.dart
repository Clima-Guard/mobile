
class RecommendationRequestDto {
  final String key;

  RecommendationRequestDto({required this.key});

  Map<String, String> toQueryParameters() => {
    'key': key,
  };
}
