import 'package:flutter/material.dart';

import 'app_state.dart';
import 'screens/add_assignment_screen.dart';
import 'screens/assignment_detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/statistics_screen.dart';

class StudyLoadApp extends StatefulWidget {
  const StudyLoadApp({super.key});

  @override
  State<StudyLoadApp> createState() => _StudyLoadAppState();
}

class _StudyLoadAppState extends State<StudyLoadApp> {
  late final AppState _state;

  @override
  void initState() {
    super.initState();
    _state = AppState();
    _state.load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Load',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: AppStateScope(
        state: _state,
        child: const HomeScreen(),
      ),
      routes: {
        '/add': (context) => AppStateScope(
              state: _state,
              child: const AddAssignmentScreen(),
            ),
        '/stats': (context) => AppStateScope(
              state: _state,
              child: const StatisticsScreen(),
            ),
      },
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '');
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'assignment') {
          final id = uri.pathSegments[1];
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) => AppStateScope(
              state: _state,
              child: AssignmentDetailScreen(assignmentId: id),
            ),
          );
        }
        return null;
      },
    );
  }
}
