
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RouteDetailsCardWidget extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String origin;
  final String destination;
  final List<String> waypoints;

  const RouteDetailsCardWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.origin,
    required this.destination,
    required this.waypoints,
  });

  @override
  State<RouteDetailsCardWidget> createState() => _RouteDetailsCardWidgetState();
}

class _RouteDetailsCardWidgetState extends State<RouteDetailsCardWidget> {
  late final DateFormat _dateTimeFormat;

  @override
  void initState() {
    super.initState();
    _dateTimeFormat = DateFormat('yyyy-MM-dd');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.info_outline, size: 28),
                  SizedBox(width: 8),
                  Text(
                    "Route Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.waypoints.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return Chip(
                        label: Text(widget.waypoints[index]),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],

              _buildDetailRow("Start Date", _dateTimeFormat.format(widget.startDate), textTheme),
              const SizedBox(height: 12),

              _buildDetailRow("End Date", _dateTimeFormat.format(widget.endDate), textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            "$label:",
            style: textTheme.labelLarge,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}