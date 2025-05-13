
import 'package:flutter/material.dart';

class RecommendationWidget extends StatefulWidget {
  final int index;

  const RecommendationWidget({
    super.key,
    required this.index
  });

  @override
  State<RecommendationWidget> createState() => _RecommendationWidgetState();
}

class _RecommendationWidgetState extends State<RecommendationWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.access_time),
      tileColor: Theme.of(context).cardColor,
      title: Text("Recommended Departure: ${8 + widget.index}:00"),
      subtitle: const Text("Estimated Time: 1h 30min - Distance: 90km"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // TODO: Add tap functionality
      },
    );
  }
}
