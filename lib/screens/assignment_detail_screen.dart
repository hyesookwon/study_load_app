import 'package:flutter/material.dart';

import '../app_state.dart';

class AssignmentDetailScreen extends StatelessWidget {
  const AssignmentDetailScreen({
    super.key,
    required this.assignmentId,
  });

  final String assignmentId;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final a = state.getById(assignmentId);

    if (a == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Assignment')),
        body: const Center(child: Text('Assignment not found')),
      );
    }

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(a.name),
        actions: [
          IconButton(
            icon: Icon(a.isDone ? Icons.check_circle : Icons.radio_button_unchecked),
            onPressed: () => state.toggleDone(a.id),
            tooltip: a.isDone ? 'Mark not done' : 'Mark done',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start date', style: theme.textTheme.labelLarge),
                    const SizedBox(height: 4),
                    Text(
                      '${a.startDate.year}-${a.startDate.month.toString().padLeft(2, '0')}-${a.startDate.day.toString().padLeft(2, '0')}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text('Deadline', style: theme.textTheme.labelLarge),
                    const SizedBox(height: 4),
                    Text(
                      '${a.deadline.year}-${a.deadline.month.toString().padLeft(2, '0')}-${a.deadline.day.toString().padLeft(2, '0')}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text('Status', style: theme.textTheme.labelLarge),
                    const SizedBox(height: 4),
                    Text(
                      a.isDone ? 'Done' : 'In progress',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: a.isDone
                            ? theme.colorScheme.primary
                            : theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
