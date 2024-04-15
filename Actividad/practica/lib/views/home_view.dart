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
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  DateTime? _deadline;
  int _currentIndex = 0;
  TaskPriority taskPriority = TaskPriority.Low;

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
        backgroundColor: Colors.blue.shade400,
        child: Icon(Icons.add, color: Colors.white),
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
            icon: Icon(Icons.check_circle, color: Colors.green),
            label: 'Completadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel_rounded, color: Colors.red),
            label: 'Incompletas',
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    final Stream<List<Task>> tasksStream = _currentIndex == 0
        ? _taskController.getCompletedTasks()
        : _taskController.getIncompleteTasks();

    return StreamBuilder<List<Task>>(
      stream: tasksStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final tasksToShow = snapshot.data ?? [];

        tasksToShow.sort((a, b) {
          int priorityComparison = b.priority.index.compareTo(a.priority.index);

          if (priorityComparison == 0) {
            return a.name.compareTo(b.name);
          }

          return priorityComparison;
        });

        return ListView.builder(
          itemCount: tasksToShow.length,
          itemBuilder: (context, index) {
            var task = tasksToShow[index];
            return ListTile(
              title: Text(task.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (task.description.isNotEmpty) Text(task.description),
                  if (task.deadline != null)
                    Text('Fecha límite: ${task.deadline}'),
                ],
              ),
              leading: Checkbox(
                value: task.completed,
                onChanged: (bool? newValue) {
                  setState(() {
                    _taskController.toggleTaskComplete(
                        task.id, newValue ?? false);
                  });
                },
                activeColor: Colors.green,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getPriorityText(task.priority),
                    style: TextStyle(
                      color: _getPriorityColor(task.priority),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue.shade400),
                    onPressed: () {
                      _showEditTaskDialog(task);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _taskController.deleteTask(task.id);
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.Low:
        return Colors.green;
      case TaskPriority.Medium:
        return Colors.orange;
      case TaskPriority.High:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  String _getPriorityText(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.Low:
        return 'Baja';
      case TaskPriority.Medium:
        return 'Media';
      case TaskPriority.High:
        return 'Alta';
      default:
        return '';
    }
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Agregar Tarea',
                  style: TextStyle(color: Colors.black)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _newTaskController,
                      decoration:
                          InputDecoration(hintText: "Nombre de la tarea"),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration:
                          InputDecoration(hintText: "Descripción de la tarea"),
                    ),
                    TextField(
                      controller: _deadlineController,
                      decoration:
                          InputDecoration(hintText: "Fecha límite (opcional)"),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null && picked != _deadline) {
                          setState(() {
                            _deadline = picked;
                            _deadlineController.text = picked.toString();
                          });
                        }
                      },
                    ),
                    DropdownButtonFormField<TaskPriority>(
                      value: TaskPriority.Low,
                      onChanged: (TaskPriority? value) {
                        setState(() {
                          taskPriority = value ?? TaskPriority.Low;
                        });
                      },
                      items: [
                        DropdownMenuItem<TaskPriority>(
                          value: TaskPriority.Low,
                          child: Text('Baja'),
                        ),
                        DropdownMenuItem<TaskPriority>(
                          value: TaskPriority.Medium,
                          child: Text('Media'),
                        ),
                        DropdownMenuItem<TaskPriority>(
                          value: TaskPriority.High,
                          child: Text('Alta'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _newTaskController.clear();
                    _descriptionController.clear();
                    _deadlineController.clear();
                  },
                ),
                ElevatedButton(
                  child: const Text('Agregar',
                      style: TextStyle(color: Colors.green)),
                  onPressed: () {
                    _taskController.addTask(
                      _newTaskController.text,
                      description: _descriptionController.text,
                      deadline: _deadline,
                      priority: taskPriority,
                    );
                    Navigator.of(context).pop();
                    _newTaskController.clear();
                    _descriptionController.clear();
                    _deadlineController.clear();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditTaskDialog(Task task) {
    _editTaskController.text = task.name;
    _descriptionController.text = task.description;
    _deadlineController.text =
        task.deadline != null ? task.deadline.toString() : '';
    taskPriority = task.priority;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Editar Tarea',
                  style: TextStyle(color: Colors.black)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _editTaskController,
                      decoration:
                          InputDecoration(hintText: "Nuevo nombre de la tarea"),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          hintText: "Nueva descripción de la tarea"),
                    ),
                    TextField(
                      controller: _deadlineController,
                      decoration: InputDecoration(
                          hintText: "Nueva fecha límite (opcional)"),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null && picked != _deadline) {
                          setState(() {
                            _deadline = picked;
                            _deadlineController.text = picked.toString();
                          });
                        }
                      },
                    ),
                    DropdownButtonFormField<TaskPriority>(
                      value: taskPriority,
                      onChanged: (TaskPriority? value) {
                        setState(() {
                          taskPriority = value ?? TaskPriority.Low;
                        });
                      },
                      items: [
                        DropdownMenuItem<TaskPriority>(
                          value: TaskPriority.Low,
                          child: Text('Baja'),
                        ),
                        DropdownMenuItem<TaskPriority>(
                          value: TaskPriority.Medium,
                          child: Text('Media'),
                        ),
                        DropdownMenuItem<TaskPriority>(
                          value: TaskPriority.High,
                          child: Text('Alta'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _editTaskController.clear();
                    _descriptionController.clear();
                    _deadlineController.clear();
                  },
                ),
                TextButton(
                  child: Text('Guardar'),
                  onPressed: () {
                    _taskController.editTask(
                      task.id,
                      _editTaskController.text,
                      newDescription: _descriptionController.text,
                      newDeadline: _deadline,
                      newPriority: taskPriority,
                    );
                    Navigator.of(context).pop();
                    _editTaskController.clear();
                    _descriptionController.clear();
                    _deadlineController.clear();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
