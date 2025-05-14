
class Coordinate {
  final double lat;
  final double lng;

  Coordinate({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() => {
    'latitude': lat,
    'longitude': lng,
  };
}

class WeatherRequestDto {
  final List<List<Coordinate>> coordinates;
  final DateTime startDate;
  final DateTime endDate;

  WeatherRequestDto({
    required this.coordinates,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
    'coordinates': coordinates
        .map((list) => list.map((coord) => coord.toJson()).toList())
        .toList(),
    'startDate': startDate.toIso8601String().split('T')[0],
    'endDate': endDate.toIso8601String().split('T')[0],
  };
}