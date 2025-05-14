
import 'package:clima_guard_mobile/views/RouteMapScreen.dart';
import 'package:clima_guard_mobile/views/widgets/RouteInputDetailsWidget.dart';
import 'package:clima_guard_mobile/views/widgets/TimePeriodWidget.dart';
import 'package:flutter/material.dart';

import '../viewmodels/RouteViewModel.dart';

class RouteInputScreen extends StatefulWidget {
  final RouteViewModel viewModel;

  const RouteInputScreen({super.key, required this.viewModel});

  @override
  State<RouteInputScreen> createState() => _RouteInputScreenState();
}

class _RouteInputScreenState extends State<RouteInputScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String? _origin;
  String? _destination;
  List<String> _waypoints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ClimaGuard")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TimePeriodWidget(
                startDate: _startDate,
                endDate: _endDate,
                onDateRangeSelected: (start, end) {
                  setState(() {
                    _startDate = start;
                    _endDate = end;
                  });
                },
              ),
              const SizedBox(height: 16),
              RouteInputDetailsWidget(
                onRouteDetailsChanged: ({required origin, required destination, required waypoints}) {
                  setState(() {
                    _origin = origin;
                    _destination = destination;
                    _waypoints = waypoints;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: (_startDate != null && _endDate != null && _origin != null && _destination != null)
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RouteMapScreen(
                        startDate: _startDate!,
                        endDate: _endDate!,
                        origin: _origin!,
                        destination: _destination!,
                        waypoints: _waypoints,
                        viewModel: widget.viewModel,
                      ),
                    ),
                  );
                } : null,
                child: const Text("Find Best Departure Time"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
