
import 'package:flutter/material.dart';

class RouteDetailsCardWidget extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String origin;
  final String destination;
  final List<String> waypoints;
  final Map<String, double>? selectedWeatherData;
  final VoidCallback onClearWeather;

  const RouteDetailsCardWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.origin,
    required this.destination,
    required this.waypoints,
    required this.selectedWeatherData,
    required this.onClearWeather,
  });

  @override
  State<RouteDetailsCardWidget> createState() => _RouteDetailsCardWidgetState();
}

class _RouteDetailsCardWidgetState extends State<RouteDetailsCardWidget> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 260,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  _buildRouteDetails(textTheme),
                  _buildWeatherDetails(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteDetails(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.info_outline, size: 28),
                SizedBox(width: 8),
                Text("Route Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailRow("Origin", widget.origin, textTheme),
            const SizedBox(height: 12),
            _buildDetailRow("Destination", widget.destination, textTheme),
            const SizedBox(height: 12),
            if (widget.waypoints.isNotEmpty) ...[
              Text("Waypoints:", style: textTheme.labelLarge),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: widget.waypoints.map((w) => Chip(label: Text(w))).toList(),
              ),
              const SizedBox(height: 16),
            ],
            _buildDetailRow("Start Date", widget.startDate.toIso8601String().split('T').first, textTheme),
            const SizedBox(height: 12),
            _buildDetailRow("End Date", widget.endDate.toIso8601String().split('T').first, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetails() {
    if (widget.selectedWeatherData == null) {
      return const Center(child: Text("No weather point selected."));
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Weather at Selected Point:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: widget.onClearWeather,
                  icon: const Icon(Icons.close, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: widget.selectedWeatherData!.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(_getWeatherIcon(entry.key, entry.value), size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${_formatConditionName(entry.key)}: ${entry.value.toStringAsFixed(1)}',
                          style: const TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 100, child: Text("$label:", style: textTheme.labelLarge)),
        Expanded(child: Text(value, style: textTheme.bodyMedium)),
      ],
    );
  }

  String _formatConditionName(String key) {
    switch (key) {
      case 'Temperature2m':
        return 'Temperature';
      case 'Precipitation':
        return 'Precipitation';
      case 'WeatherCode':
        return 'Weather';
      case 'Visibility':
        return 'Visibility';
      case 'WindSpeed10m':
        return 'Wind Speed';
      case 'WindGusts10m':
        return 'Wind Gusts';
      case 'FreezingLevelHeight':
        return 'Freezing Height';
      default:
        return key;
    }
  }

  IconData _getWeatherIcon(String condition, double value) {
    switch (condition) {
      case 'Temperature2m':
        return Icons.thermostat;
      case 'Precipitation':
        return Icons.umbrella;
      case 'WeatherCode':
        if (value == 0) return Icons.wb_sunny;
        if (value == 1 || value == 2) return Icons.cloud;
        if (value == 3) return Icons.cloud_queue;
        if (value >= 45 && value <= 48) return Icons.foggy;
        if (value >= 51 && value <= 67) return Icons.grain;
        if (value >= 71 && value <= 77) return Icons.ac_unit;
        if (value >= 80 && value <= 82) return Icons.grain;
        if (value >= 95) return Icons.flash_on;
        return Icons.help_outline;
      case 'Visibility':
        return Icons.remove_red_eye;
      case 'WindSpeed10m':
      case 'WindGusts10m':
        return Icons.air;
      case 'FreezingLevelHeight':
        return Icons.ac_unit;
      default:
        return Icons.help_outline;
    }
  }
}
