
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecommendationWidget extends StatelessWidget {
  final int index;
  final DateTime departureTime;
  final int distance;
  final Duration duration;
  final bool isSelected;
  final VoidCallback onTap;

  const RecommendationWidget({
    super.key,
    required this.index,
    required this.departureTime,
    required this.distance,
    required this.duration,
    required this.isSelected,
    required this.onTap,
  });

  String formatDistance(int meters) {
    double kilometers = meters / 1000.0;
    return '${kilometers.toStringAsFixed(1)} km';
  }

  String formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    } else {
      return '${duration.inMinutes}m';
    }
  }

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isSelected ? Theme.of(context).colorScheme.primary : null,
      leading: CircleAvatar(
        child: Text('${index + 1}'),
      ),
      title: Text(
        'Departure: ${formatDateTime(departureTime)}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        'Distance: ${formatDistance(distance)}\nDuration: ${formatDuration(duration)}',
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
