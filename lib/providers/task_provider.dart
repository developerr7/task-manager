import 'package:flutter/material.dart';
import 'package:tasky_app/constants/enum.dart';
import 'package:tasky_app/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  int totalTaskCount({DateTime? date}) {
    final targetDate = date ?? DateTime.now();
    return _tasks.where((task) => isSameDay(task.date, targetDate)).length;
  }

  int completedTaskCount({DateTime? date}) {
    final targetDate = date ?? DateTime.now();
    return _tasks
        .where((task) =>
            task.status == TaskStatus.completed &&
            isSameDay(task.date, targetDate))
        .length;
  }

  List<Task> getTasks({DateTime? date}) {
    if (date != null) {
      return tasks.where((task) => isSameDay(task.date, date)).toList();
    }

    return tasks;
  }

  void addTask(Task task) {
    _tasks.add(task);
    for (int i = 0; i < _tasks.length; i++) {
      print(_tasks[i].status);
      print(_tasks[i].isCompleted);
      print(_tasks[i].name);
      print(_tasks[i].description);
      print(_tasks[i].date.toString());
    }
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateTask(Task oldTask, Task newTask) {
    int index = _tasks.indexOf(oldTask);
    if (index != -1) {
      _tasks[index] = newTask;
      for (int i = 0; i < _tasks.length; i++) {
        print(_tasks[i].status);
        print(_tasks[i].isCompleted);
        print(_tasks[i].name);
        print(_tasks[i].description);
        print(_tasks[i].date.toString());
      }
      notifyListeners();
    }
  }

  void toggleTaskCompletion(Task task) {
    int index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index].isCompleted = !task.isCompleted;
      _tasks[index].status = task.status == TaskStatus.remaining
          ? TaskStatus.completed
          : TaskStatus.remaining;

      for (int i = 0; i < _tasks.length; i++) {
        print(_tasks[i].status);
        print(_tasks[i].isCompleted);
        print(_tasks[i].name);
        print(_tasks[i].description);
        print(_tasks[i].date.toString());
      }
      notifyListeners();
    }
  }

  List<Task> getSortedTasks(SortOption option, {DateTime? date}) {
    List<Task> filteredTasks = getTasks(date: date);
    List<Task> sortedTasks = List.from(filteredTasks);

    if (option == SortOption.byStatus) {
      sortedTasks.sort((a, b) => b.isCompleted ? 1 : -1);
    } else if (option == SortOption.byPriority) {
      const priorityOrder = {'High': 1, 'Medium': 2, 'Low': 3};
      sortedTasks.sort((a, b) {
        final aPriorityValue = priorityOrder[a.priority] ?? 0;
        final bPriorityValue = priorityOrder[b.priority] ?? 0;
        return aPriorityValue.compareTo(bPriorityValue);
      });
    }

    return sortedTasks;
  }
}
