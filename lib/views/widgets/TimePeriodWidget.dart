import 'package:flutter/material.dart';

class TimePeriodWidget extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final void Function(DateTime? start, DateTime? end) onDateRangeSelected;

  const TimePeriodWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onDateRangeSelected,
  });

  @override
  State<TimePeriodWidget> createState() => _TimePeriodWidgetState();
}

class _TimePeriodWidgetState extends State<TimePeriodWidget> {
  Future<void> _showDateRangePicker() async {
    final initialStartDate = widget.startDate ?? DateTime.now();
    final initialEndDate = widget.endDate ?? DateTime.now().add(const Duration(days: 7));

    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: initialStartDate, end: initialEndDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: Theme.of(context).primaryColor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.onDateRangeSelected(picked.start, picked.end);
    }
  }

  String _formatDate(DateTime? date) {
    return date != null
        ? "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}"
        : "No date selected";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _showDateRangePicker,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Start Date"),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(widget.startDate),
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, size: 24),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("End Date"),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(widget.endDate),
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
