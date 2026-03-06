import 'package:flutter/widgets.dart';

import 'models/assignment.dart';
import 'services/storage_service.dart';

class AppState extends ChangeNotifier {
  List<Assignment> _assignments = [];

  List<Assignment> get assignments => List.unmodifiable(_assignments);

  Future<void> load() async {
    _assignments = StorageService.loadAssignments();
    notifyListeners();
  }

  Future<void> addAssignment(Assignment a) async {
    _assignments = [..._assignments, a];
    await StorageService.saveAssignments(_assignments);
    notifyListeners();
  }

  Future<void> updateAssignment(Assignment a) async {
    final i = _assignments.indexWhere((x) => x.id == a.id);
    if (i < 0) return;
    _assignments = [..._assignments];
    _assignments[i] = a;
    await StorageService.saveAssignments(_assignments);
    notifyListeners();
  }

  Future<void> removeAssignment(String id) async {
    _assignments = _assignments.where((a) => a.id != id).toList();
    await StorageService.saveAssignments(_assignments);
    notifyListeners();
  }

  Future<void> toggleDone(String id) async {
    final i = _assignments.indexWhere((a) => a.id == id);
    if (i < 0) return;
    final a = _assignments[i];
    _assignments = [..._assignments];
    _assignments[i] = a.copyWith(isDone: !a.isDone);
    await StorageService.saveAssignments(_assignments);
    notifyListeners();
  }

  Assignment? getById(String id) {
    try {
      return _assignments.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}

class AppStateScope extends InheritedWidget {
  const AppStateScope({super.key, required this.state, required super.child});

  final AppState state;

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found');
    return scope!.state;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) => state != oldWidget.state;
}
