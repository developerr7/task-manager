import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/constants/app_colors.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/providers/task_provider.dart';
import 'package:tasky_app/widgets/app_bar_widget.dart';
import 'package:tasky_app/widgets/button_widget.dart';

class TaskCreateScreen extends StatefulWidget {
  const TaskCreateScreen({super.key});

  @override
  _TaskCreateScreenState createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _priority = 'Low';

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);

      final Task singleTask = Task(
        name: _nameController.text,
        description: _descriptionController.text,
        date: _selectedDate,
        priority: _priority,
      );

      taskProvider.addTask(singleTask);

      _nameController.clear();
      _descriptionController.clear();

      setState(() {
        _selectedDate = DateTime.now();
        _priority = 'Low';
      });

      Navigator.pop(
        context,
        '/task',
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.white,
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(
        title: 'Create a Task',
        leadingIcon: 'assets/icons/short_left.svg',
        onActionPressed: () {},
        bgColor: AppColors.primaryColor,
        iconColor: AppColors.darkThemeTextColor,
        showLeadingIcon: true,
        showActionIcon: false,
        leadingIconColor: const Color(0xFF324646),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _nameController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Task Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the task name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _descriptionController,
                  maxLength: 250,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                    ),
                    child: Text(
                      DateFormat.yMMMd().format(_selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                DropdownButtonFormField<String>(
                  value: _priority,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                  ),
                  items: <String>['Low', 'Medium', 'High']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _priority = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a priority';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                DynamicButton(
                  label: 'Save Task',
                  onPressed: () => _submitForm(context),
                  backgroundColor: AppColors.cardGradientColorSecond,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
