
import 'package:flutter/material.dart';

import 'RecommendationWidget.dart';

class RecommendationContainerWidget extends StatefulWidget {
  const RecommendationContainerWidget({super.key});

  @override
  State<RecommendationContainerWidget> createState() => _RecommendationContainerWidgetState();
}

class _RecommendationContainerWidgetState extends State<RecommendationContainerWidget> {
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
            itemCount: 3,
            itemBuilder: (context, index) {
              return RecommendationWidget(
                index: index,
              );
            },
          ),
        );
      },
    );
  }
}
