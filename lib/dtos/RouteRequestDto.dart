
class RouteRequestDto {
  final String origin;
  final String destination;
  final List<String> waypoints;

  RouteRequestDto({
    required this.origin,
    required this.destination,
    required this.waypoints,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {
      'origin': origin,
      'destination': destination,
    };

    for (String waypoint in waypoints) {
      params.putIfAbsent('waypoints', () => []).add(waypoint);
    }

    return params;
  }
}

