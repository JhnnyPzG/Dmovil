import 'package:flutter/material.dart';
import '../models/task.dart';
import '../controllers/task_controller.dart';

enum TaskFilter { all, completed, incomplete }

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskController _taskController = TaskController();
  final TextEditingController _newTaskController = TextEditingController();
  final TextEditingController _editTaskController = TextEditingController();
  TaskFilter _filter = TaskFilter.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                _filter = _getNextFilter(_filter);
              });
            },
          ),
        ],
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList() {
    final tasksToShow = _getFilteredTasks();
    return ListView.builder(
      itemCount: tasksToShow.length,
      itemBuilder: (context, index) {
        var task = tasksToShow[index];
        return ListTile(
          title: Text(task.name), // Descripción de la tarea
          leading: Checkbox(
            value: task.completed,
            onChanged: (bool? newValue) {
              setState(() {
                task.toggleComplete();
              });
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _showEditTaskDialog(task);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _taskController.deleteTask(task);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Tarea'),
          content: TextField(
            controller: _newTaskController,
            decoration: InputDecoration(hintText: "Nombre de la tarea"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
                _newTaskController.clear();
              },
            ),
            TextButton(
              child: Text('Agregar'),
              onPressed: () {
                setState(() {
                  _taskController.addTask(_newTaskController.text);
                });
                Navigator.of(context).pop();
                _newTaskController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(Task task) {
    _editTaskController.text = task.name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Tarea'),
          content: TextField(
            controller: _editTaskController,
            decoration: InputDecoration(hintText: "Nuevo nombre de la tarea"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
                _editTaskController.clear();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                setState(() {
                  _taskController.editTask(task, _editTaskController.text);
                });
                Navigator.of(context).pop();
                _editTaskController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  List<Task> _getFilteredTasks() {
    switch (_filter) {
      case TaskFilter.completed:
        return _taskController.getCompletedTasks();
      case TaskFilter.incomplete:
        return _taskController.getIncompleteTasks();
      case TaskFilter.all:
      default:
        return _taskController.getAllTasks();
    }
  }

  TaskFilter _getNextFilter(TaskFilter currentFilter) {
    switch (currentFilter) {
      case TaskFilter.completed:
        return TaskFilter.incomplete;
      case TaskFilter.incomplete:
        return TaskFilter.all;
      case TaskFilter.all:
      default:
        return TaskFilter.completed;
    }
  }
}
