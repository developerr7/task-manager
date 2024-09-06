import 'package:tasky_app/constants/enum.dart';

class Task {
  final String name;
  final String description;
  final DateTime date;
  final String priority;
  bool isCompleted;
  TaskStatus status;

  Task({
    required this.name,
    required this.description,
    required this.date,
    required this.priority,
    this.isCompleted = false,
    this.status = TaskStatus.remaining,
  });
}
