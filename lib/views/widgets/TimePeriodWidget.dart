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
        : "Select Date";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_month, size: 48),
            const SizedBox(height: 12),
            Text(
              "Select your travel period",
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Departure",
                        style: textTheme.labelLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _formatDate(widget.startDate),
                        style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward, size: 28),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Return",
                        style: textTheme.labelLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _formatDate(widget.endDate),
                        style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showDateRangePicker,
              icon: const Icon(Icons.edit_calendar),
              label: const Text("Change Dates"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
