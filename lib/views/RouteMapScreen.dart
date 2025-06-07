
import 'package:flutter/material.dart';

import '../viewmodels/RouteViewModel.dart';
import 'widgets/GoogleMapWidget.dart';
import 'widgets/RecommendationContainerWidget.dart';
import 'widgets/RouteDetailsCardWidget.dart';

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
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
              isPortrait
                  ? Column(
                children: [
                  // Let this take only what's needed, scrollable if needed
                  Flexible(
                    flex: 4,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: RouteDetailsCardWidget(
                        startDate: widget.startDate,
                        endDate: widget.endDate,
                        origin: widget.origin,
                        destination: widget.destination,
                        waypoints: widget.waypoints,
                        selectedWeatherData: widget.viewModel.selectedWeatherData,
                        onClearWeather: () {
                          setState(() {
                            widget.viewModel.selectedWeatherData = null;
                          });
                        },
                      ),
                    ),
                  ),
                  // Map takes the rest
                  Expanded(
                    flex: 6,
                    child: GoogleMapWidget(
                      interpolatedPoints: selectedRoute.interpolatedPoints,
                      polylinePoints: selectedRoute.routeData.decodedPolyline,
                      weatherConditions: selectedRoute.weatherConditions,
                      onMarkerSelected: (int markerIndex) {
                        setState(() {
                          widget.viewModel.selectedWeatherData =
                          selectedRoute.weatherConditions[markerIndex];
                        });
                      },
                    ),
                  ),
                ],
              )
                  : Row(
                children: [
                  // Let details scroll if needed
                  SizedBox(
                    width: 350,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: RouteDetailsCardWidget(
                        startDate: widget.startDate,
                        endDate: widget.endDate,
                        origin: widget.origin,
                        destination: widget.destination,
                        waypoints: widget.waypoints,
                        selectedWeatherData: widget.viewModel.selectedWeatherData,
                        onClearWeather: () {
                          setState(() {
                            widget.viewModel.selectedWeatherData = null;
                          });
                        },
                      ),
                    ),
                  ),
                  // Map fills the rest
                  Expanded(
                    child: GoogleMapWidget(
                      interpolatedPoints: selectedRoute.interpolatedPoints,
                      polylinePoints: selectedRoute.routeData.decodedPolyline,
                      weatherConditions: selectedRoute.weatherConditions,
                      onMarkerSelected: (int markerIndex) {
                        setState(() {
                          widget.viewModel.selectedWeatherData =
                          selectedRoute.weatherConditions[markerIndex];
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Recommendation overlay
              RecommendationContainerWidget(
                fullRoutes: widget.viewModel.fullRoutes,
                selectedIndex: selectedRouteIndex,
                onSelected: (newIndex) {
                  setState(() {
                    selectedRouteIndex = newIndex;
                    widget.viewModel.selectedWeatherData = null;
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
