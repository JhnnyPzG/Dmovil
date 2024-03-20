class Task {
  String name;
  bool completed;

  Task({required this.name, this.completed = false});

  void toggleComplete() {
    completed = !completed;
  }

  @override
  String toString() {
    return 'Task(name: $name, completed: $completed)';
  }
}
