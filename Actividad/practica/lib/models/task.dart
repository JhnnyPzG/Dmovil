class Task {
  String name;
  String description;
  DateTime? deadline;
  TaskPriority priority;
  bool completed;

  Task({
    required this.name,
    this.description = '',
    this.deadline,
    this.priority = TaskPriority.Low,
    this.completed = false,
  });

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
