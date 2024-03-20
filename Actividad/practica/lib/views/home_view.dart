import 'package:flutter/material.dart';
import '../models/task.dart';
import '../controllers/task_controller.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskController _taskController = TaskController();
  final TextEditingController _newTaskController = TextEditingController();
  final TextEditingController _editTaskController = TextEditingController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Completadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio_button_unchecked),
            label: 'Incompletas',
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    final List<Task> tasksToShow = _currentIndex == 0
        ? _taskController.getCompletedTasks()
        : _taskController.getIncompleteTasks();

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
}
