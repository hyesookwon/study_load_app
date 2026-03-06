import 'package:flutter/material.dart';

import '../app_state.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/week_table.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final today = DateTime.now();

    return ResponsiveLayout(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Study Load'),
          actions: [
            IconButton(
              icon: const Icon(Icons.bar_chart),
              onPressed: () => Navigator.of(context).pushNamed('/stats'),
              tooltip: 'Statistics',
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Week of ${_weekRange(today)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: state,
                builder: (context, _) {
                  final assignments = state.assignments;
                  if (assignments.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: 64,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No assignments yet',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          FilledButton.icon(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/add'),
                            icon: const Icon(Icons.add),
                            label: const Text('Add assignment'),
                          ),
                        ],
                      ),
                    );
                  }
                  return WeekTable(
                    assignments: assignments,
                    today: today,
                    onToggleDone: state.toggleDone,
                    onTapAssignment: (id) {
                      Navigator.of(context).pushNamed('/assignment/$id');
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).pushNamed('/add'),
          icon: const Icon(Icons.add),
          label: const Text('Add'),
        ),
      ),
    );
  }

  String _weekRange(DateTime today) {
    final mon = today.subtract(Duration(days: today.weekday - 1));
    final sun = mon.add(const Duration(days: 6));
    return '${mon.month}/${mon.day} – ${sun.month}/${sun.day}';
  }
}
