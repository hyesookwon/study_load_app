import 'package:flutter/material.dart';

import '../models/assignment.dart';

/// Monday = 1, Sunday = 7. Returns Monday of the week that contains [date].
DateTime _mondayOfWeek(DateTime date) {
  final wday = date.weekday;
  return DateTime(date.year, date.month, date.day - (wday - 1));
}

/// Days from [start] to [end] (inclusive). [start] and [end] are dates only (time ignored).
int _daysBetween(DateTime start, DateTime end) {
  final a = DateTime(start.year, start.month, start.day);
  final b = DateTime(end.year, end.month, end.day);
  return b.difference(a).inDays;
}

/// Row colors (non-greyscale) for assignments. Cycle by index.
const List<Color> _rowColors = [
  Color(0xFF1565C0), // blue
  Color(0xFF2E7D32), // green
  Color(0xFF6A1B9A), // purple
  Color(0xFFC62828), // red
  Color(0xFFE65100), // orange
  Color(0xFF00838F), // cyan
  Color(0xFF283593), // indigo
];

Color _colorForIndex(int index) {
  return _rowColors[index % _rowColors.length];
}


class WeekTable extends StatelessWidget {
  const WeekTable({
    super.key,
    required this.assignments,
    required this.today,
    required this.onToggleDone,
    required this.onTapAssignment,
  });

  final List<Assignment> assignments;
  final DateTime today;
  final void Function(String id) onToggleDone;
  final void Function(String id) onTapAssignment;

  @override
  Widget build(BuildContext context) {
    final monday = _mondayOfWeek(today);
    final weekDays = List.generate(7, (i) => monday.add(Duration(days: i)));
    final todayYmd = DateTime(today.year, today.month, today.day);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(isNarrow ? 120 : 180),
                for (int i = 1; i <= 7; i++)
                  i: FixedColumnWidth(isNarrow ? 44 : 72),
              },
              border: TableBorder.all(color: Theme.of(context).dividerColor),
              children: [
                _headerRow(context, weekDays, todayYmd),
                for (int i = 0; i < assignments.length; i++)
                  _dataRow(
                    context,
                    assignments[i],
                    i,
                    weekDays,
                    todayYmd,
                    isNarrow,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  TableRow _headerRow(
    BuildContext context,
    List<DateTime> weekDays,
    DateTime todayYmd,
  ) {
    final theme = Theme.of(context);
    return TableRow(
      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Text(
            'Assignment',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...weekDays.map((d) {
          final isToday = DateTime(d.year, d.month, d.day) == todayYmd;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isToday
                  ? theme.colorScheme.primaryContainer
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d.weekday - 1],
                  style: theme.textTheme.labelSmall,
                ),
                Text(
                  '${d.day}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: isToday ? FontWeight.bold : null,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  TableRow _dataRow(
    BuildContext context,
    Assignment a,
    int colorIndex,
    List<DateTime> weekDays,
    DateTime todayYmd,
    bool isNarrow,
  ) {
    final isDone = a.isDone;
    Color baseColor = isDone
        ? Colors.grey
        : _colorForIndex(colorIndex);

    return TableRow(
      children: [
        Container(
          decoration: BoxDecoration(color: baseColor.withAlpha(255)),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => onTapAssignment(a.id),
                  child: Text(
                    a.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isDone ? Colors.grey.shade700 : null,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  a.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                  size: isNarrow ? 20 : 24,
                ),
                onPressed: () => onToggleDone(a.id),
                tooltip: a.isDone ? 'Mark not done' : 'Mark done',
              ),
            ],
          ),
        ),
        ...weekDays.map((d) {
          final isToday = DateTime(d.year, d.month, d.day) == todayYmd;
          final dayYmd = DateTime(d.year, d.month, d.day);
          final startYmd = DateTime(a.startDate.year, a.startDate.month, a.startDate.day);
          final deadlineYmd = DateTime(a.deadline.year, a.deadline.month, a.deadline.day);
          final isWithinPeriod = !dayYmd.isBefore(startYmd) && !dayYmd.isAfter(deadlineYmd);
          String? dDayText;
          if (isWithinPeriod && !isDone) {
            final daysUntilDeadline = _daysBetween(dayYmd, deadlineYmd);
            if (daysUntilDeadline == 0) {
              dDayText = 'D-day';
            } else {
              dDayText = 'D-$daysUntilDeadline';
            }
          }
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: isToday
                  ? Border(
                      left: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                      ),
                      right: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                      ),
                    )
                  : null,
            ),
            child: dDayText != null
                ? Text(
                    dDayText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : null,
          );
        }),
      ],
    );
  }
}
