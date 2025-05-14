
import 'package:clima_guard_mobile/views/widgets/GoogleMapWidget.dart';
import 'package:clima_guard_mobile/views/widgets/RecommendationContainerWidget.dart';
import 'package:clima_guard_mobile/views/widgets/RouteDetailsCardWidget.dart';
import 'package:flutter/material.dart';

import '../viewmodels/RouteViewModel.dart';

class RouteMapScreen extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String origin;
  final String destination;
  final List<String> waypoints;
  final RouteViewModel viewModel;

  const RouteMapScreen({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.origin,
    required this.destination,
    required this.waypoints,
    required this.viewModel,
  });

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  int selectedRouteIndex = 0;

  @override
  void initState() {
    super.initState();

    widget.viewModel.loadFullRouteData(
      origin: widget.origin,
      destination: widget.destination,
      waypoints: widget.waypoints,
      startDate: widget.startDate,
      endDate: widget.endDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ClimaGuard")),
      body: AnimatedBuilder(
        animation: widget.viewModel,
        builder: (context, _) {
          if (widget.viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.viewModel.errorMessage != null) {
            return Center(child: Text('Error: ${widget.viewModel.errorMessage}'));
          }

          if (widget.viewModel.fullRoutes.isEmpty) {
            return const Center(child: Text('No route data'));
          }

          final selectedRoute = widget.viewModel.fullRoutes[selectedRouteIndex];

          return Stack(
            children: [
              Column(
                children: [
                  RouteDetailsCardWidget(
                    startDate: widget.startDate,
                    endDate: widget.endDate,
                    origin: widget.origin,
                    destination: widget.destination,
                    waypoints: widget.waypoints,
                  ),
                  Expanded(
                    child: GoogleMapWidget(
                      interpolatedPoints: selectedRoute.interpolatedPoints,
                      polylinePoints: selectedRoute.routeData.decodedPolyline,
                    ),
                  ),
                ],
              ),
              RecommendationContainerWidget(
                fullRoutes: widget.viewModel.fullRoutes,
                selectedIndex: selectedRouteIndex,
                onSelected: (newIndex) {
                  setState(() {
                    selectedRouteIndex = newIndex;
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }

}
