import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/assignment.dart';

const String _boxName = 'study_load';
const String _assignmentsKey = 'assignments';

class StorageService {
  static late Box<String> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<String>(_boxName);
  }

  static List<Assignment> loadAssignments() {
    final raw = _box.get(_assignmentsKey);
    if (raw == null) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => Assignment.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('StorageService.loadAssignments error: $e');
      return [];
    }
  }

  static Future<void> saveAssignments(List<Assignment> assignments) async {
    final list = assignments.map((e) => e.toMap()).toList();
    await _box.put(_assignmentsKey, jsonEncode(list));
  }
}
