
import 'package:flutter/material.dart';

import 'GooglePlacesSearchBarWidget.dart';

class RouteDetailsWidget extends StatefulWidget {
  const RouteDetailsWidget({super.key});

  @override
  State<RouteDetailsWidget> createState() => _RouteDetailsWidgetState();
}

class _RouteDetailsWidgetState extends State<RouteDetailsWidget> {
  List<Widget> waypoints = [];

  static const int maxWaypoints = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GooglePlacesSearchBarWidget(),

            SizedBox(height: 16),

            GooglePlacesSearchBarWidget(),

            SizedBox(height: 16),

            ...waypoints,

            if (waypoints.length < maxWaypoints)
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    setState(() {
                      waypoints.add(GooglePlacesSearchBarWidget());
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}