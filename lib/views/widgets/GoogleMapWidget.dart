
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  final List<LatLng> interpolatedPoints;
  final List<LatLng> polylinePoints;
  final List<Map<String, double>> weatherConditions;
  final void Function(int selectedIndex) onMarkerSelected;

  const GoogleMapWidget({
    super.key,
    required this.interpolatedPoints,
    required this.polylinePoints,
    required this.weatherConditions,
    required this.onMarkerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: polylinePoints.first,
        zoom: 8,
      ),
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          color: Color(0xFF1D3557),
          width: 5,
          points: polylinePoints,
        ),
      },
      markers: {
        for (int i = 0; i < interpolatedPoints.length; i++)
          Marker(
            markerId: MarkerId("point_$i"),
            position: interpolatedPoints[i],
            onTap: () => onMarkerSelected(i),
          ),
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
