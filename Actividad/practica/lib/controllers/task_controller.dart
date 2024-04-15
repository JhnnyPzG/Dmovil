import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class TaskController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTask(String name,
      {String description = '',
      DateTime? deadline,
      TaskPriority priority = TaskPriority.Low}) async {
    await _firestore.collection('tasks').add({
      'name': name,
      'description': description,
      'deadline': deadline,
      'priority': priority.toString(),
      'completed': false,
    });
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }

  Future<void> toggleTaskComplete(String taskId, bool completed) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'completed': completed,
    });
  }

  Future<void> editTask(String taskId, String newName,
      {String newDescription = '',
      DateTime? newDeadline,
      TaskPriority newPriority = TaskPriority.Low}) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'name': newName,
      'description': newDescription,
      'deadline': newDeadline,
      'priority': newPriority.toString(),
    });
  }

  Stream<List<Task>> getAllTasks() {
    return _firestore.collection('tasks').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList());
  }

  Stream<List<Task>> getCompletedTasks() {
    return _firestore
        .collection('tasks')
        .where('completed', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList());
  }

  Stream<List<Task>> getIncompleteTasks() {
    return _firestore
        .collection('tasks')
        .where('completed', isEqualTo: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList());
  }
}
