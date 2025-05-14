
import 'package:clima_guard_mobile/models/RouteMergedData.dart';
import 'package:flutter/material.dart';

import 'RecommendationWidget.dart';

class RecommendationContainerWidget extends StatelessWidget {
  final List<RouteMergedData> fullRoutes;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const RecommendationContainerWidget({
    super.key,
    required this.fullRoutes,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.1,
      maxChildSize: 0.5,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ListView.builder(
            controller: scrollController,
            itemCount: fullRoutes.length,
            itemBuilder: (context, index) {
              final route = fullRoutes[index];
              return RecommendationWidget(
                index: index,
                departureTime: route.recommendedDepartureTime,
                distance: route.routeData.distanceMeters,
                duration: route.routeData.duration,
                isSelected: selectedIndex == index,
                onTap: () => onSelected(index),
              );
            },
          ),
        );
      },
    );
  }
}
