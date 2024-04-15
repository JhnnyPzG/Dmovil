import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String name;
  String description;
  DateTime? deadline;
  TaskPriority priority;
  bool completed;

  Task({
    required this.id,
    required this.name,
    this.description = '',
    this.deadline,
    this.priority = TaskPriority.Low,
    this.completed = false,
  });

  Task.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        name = doc['name'],
        description = doc['description'] ?? '',
        deadline = (doc['deadline'] as Timestamp?)?.toDate(),
        priority = TaskPriority.values.firstWhere(
            (e) => e.toString() == 'TaskPriority.' + doc['priority']),
        completed = doc['completed'] ?? false;

  void toggleComplete() {
    completed = !completed;
  }

  @override
  String toString() {
    return 'Task(name: $name, description: $description, deadline: $deadline, completed: $completed)';
  }

  setPriority(TaskPriority newPriority) {
    priority = newPriority;
  }
}

enum TaskPriority {
  Low,
  Medium,
  High,
}
