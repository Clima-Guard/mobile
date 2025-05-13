
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/PolylineDecoder.dart';

class GoogleMapWidget extends StatefulWidget {
  final List<LatLng> interpolatedPoints;
  final String polyline;

  const GoogleMapWidget({
    super.key,
    required this.interpolatedPoints,
    required this.polyline
  });

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
         mapController = controller;
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(46.77, 23.59),
        zoom: 12,
      ),
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          color: const Color(0xFF1D3557),
          width: 5,
          points: PolylineDecoder.decode(widget.polyline.replaceAll(r"\'''", r"'''").replaceAll(r"\\", r"\")),
        ),
      },
      markers: {
        for (int i = 0; i < widget.interpolatedPoints.length; i++)
          Marker(
            markerId: MarkerId("point_$i"),
            position: widget.interpolatedPoints[i],
            icon: BitmapDescriptor.defaultMarker,
          ),
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
