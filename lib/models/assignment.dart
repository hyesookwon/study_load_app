/// Assignment model: name, start date, deadline, and done state.
class Assignment {
  Assignment({
    required this.id,
    required this.name,
    required this.startDate,
    required this.deadline,
    this.isDone = false,
  });

  final String id;
  final String name;
  final DateTime startDate;
  final DateTime deadline;
  final bool isDone;

  Assignment copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? deadline,
    bool? isDone,
  }) {
    return Assignment(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      deadline: deadline ?? this.deadline,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'isDone': isDone,
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'] as String,
      name: map['name'] as String,
      startDate: DateTime.parse(map['startDate'] as String),
      deadline: DateTime.parse(map['deadline'] as String),
      isDone: (map['isDone'] as bool?) ?? false,
    );
  }
}
