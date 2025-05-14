import 'package:flutter/material.dart';
import 'GooglePlacesSearchBarWidget.dart';

class RouteInputDetailsWidget extends StatefulWidget {
  final void Function({
  required String? origin,
  required String? destination,
  required List<String> waypoints,
  }) onRouteDetailsChanged;

  const RouteInputDetailsWidget({super.key, required this.onRouteDetailsChanged});

  @override
  State<RouteInputDetailsWidget> createState() => _RouteInputDetailsWidgetState();
}

class _RouteInputDetailsWidgetState extends State<RouteInputDetailsWidget> {
  String? origin;
  String? destination;
  List<String?> waypoints = [];
  static const int maxWaypoints = 10;

  void _updateParent() {
    widget.onRouteDetailsChanged(
      origin: origin,
      destination: destination,
      waypoints: waypoints.whereType<String>().toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.route, size: 40),
                  SizedBox(width: 8),
                  Text(
                    "Plan Your Route",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Text("Origin", style: textTheme.labelLarge),
              const SizedBox(height: 8),
              GooglePlacesSearchBarWidget(
                onPlaceSelected: (value) {
                  setState(() {
                    origin = value;
                    _updateParent();
                  });
                },
              ),

              const SizedBox(height: 24),

              Text("Destination", style: textTheme.labelLarge),
              const SizedBox(height: 8),
              GooglePlacesSearchBarWidget(
                onPlaceSelected: (value) {
                  setState(() {
                    destination = value;
                    _updateParent();
                  });
                },
              ),

              const SizedBox(height: 24),

              if (waypoints.isNotEmpty) Text("Waypoints", style: textTheme.labelLarge),
              const SizedBox(height: 8),

              Column(
                children: waypoints.asMap().entries.map((entry) {
                  int index = entry.key;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          child: Text('${index + 1}', style: const TextStyle(fontSize: 12)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GooglePlacesSearchBarWidget(
                            initialValue: waypoints[index] ?? '',
                            onPlaceSelected: (value) {
                              setState(() {
                                waypoints[index] = value;
                                _updateParent();
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                          onPressed: () {
                            setState(() {
                              waypoints.removeAt(index);
                              _updateParent();
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              if (waypoints.length < maxWaypoints)
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        waypoints.add(null);
                        _updateParent();
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Waypoint"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(200, 48),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
