import 'package:flutter/material.dart';

import '../app_state.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: ListenableBuilder(
        listenable: state,
        builder: (context, _) {
          final assignments = state.assignments;
          final total = assignments.length;
          final done = assignments.where((a) => a.isDone).length;
          final pending = total - done;
          final overdue = assignments
              .where((a) => !a.isDone && a.deadline.isBefore(DateTime.now()))
              .length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _StatCard(
                  title: 'Total assignments',
                  value: '$total',
                  icon: Icons.assignment,
                ),
                const SizedBox(height: 16),
                _StatCard(
                  title: 'Done',
                  value: '$done',
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                _StatCard(
                  title: 'Pending',
                  value: '$pending',
                  icon: Icons.schedule,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                _StatCard(
                  title: 'Overdue',
                  value: '$overdue',
                  icon: Icons.warning,
                  color: Colors.red,
                ),
                if (total > 0) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Completion: ${(100 * done / total).toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color ?? theme.colorScheme.primary),
        title: Text(title),
        trailing: Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
