
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
          clipBehavior: Clip.antiAlias,
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.titleLarge?.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: fullRoutes.length,
                  itemBuilder: (context, index) {
                    final route = fullRoutes[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: RecommendationWidget(
                        index: index,
                        localDepartureTime: route.recommendedLocalDepartureTime,
                        utcDepartureTime: route.recommendedUtcDepartureTime,
                        distance: route.routeData.distanceMeters,
                        duration: route.routeData.duration,
                        isSelected: selectedIndex == index,
                        onTap: () => onSelected(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
