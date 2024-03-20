import '../models/task.dart';

class TaskController {
  List<Task> _tasks = [];

  void addTask(String name) {
    final task = Task(name: name);
    _tasks.add(task);
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
  }

  void toggleTaskComplete(Task task) {
    task.toggleComplete();
  }

  void editTask(Task task, String newName) {
    task.name = newName;
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
