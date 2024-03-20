import '../models/task.dart';

class TaskController {
  List<Task> _tasks = [];

  void addTask(String name,
      {String description = '',
      DateTime? deadline,
      TaskPriority priority = TaskPriority.Low}) {
    final task = Task(
        name: name,
        description: description,
        deadline: deadline,
        priority: priority);
    _tasks.add(task);
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
  }

  void toggleTaskComplete(Task task) {
    task.toggleComplete();
  }

  void editTask(Task task, String newName,
      {String newDescription = '',
      DateTime? newDeadline,
      TaskPriority newPriority = TaskPriority.Low}) {
    task.name = newName;
    task.description = newDescription;
    task.deadline = newDeadline;
    task.priority = newPriority;
  }

  List<Task> getAllTasks() {
    return List.from(_tasks);
  }

  List<Task> getCompletedTasks() {
    return _tasks.where((task) => task.completed).toList();
  }

  List<Task> getIncompleteTasks() {
    return _tasks.where((task) => !task.completed).toList();
  }
}
