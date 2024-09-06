import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/constants/app_colors.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/providers/task_provider.dart';
import 'package:tasky_app/widgets/app_bar_widget.dart';
import 'package:tasky_app/widgets/button_widget.dart';
import 'package:tasky_app/widgets/chip_widget.dart';

class SingleTaskScreen extends StatefulWidget {
  Task task;

  SingleTaskScreen({super.key, required this.task});

  @override
  _SingleTaskScreenState createState() => _SingleTaskScreenState();
}

class _SingleTaskScreenState extends State<SingleTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late String _selectedPriority;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.task.name);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _selectedDate = widget.task.date;
    _selectedPriority = widget.task.priority;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        _initializeControllers();
      }
    });
  }

  void deleteTask() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.removeTask(widget.task);
    Navigator.pop(context);
  }

  void saveTask() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final updatedTask = Task(
      name: _nameController.text,
      description: _descriptionController.text,
      date: _selectedDate,
      priority: _selectedPriority,
      isCompleted: widget.task.isCompleted,
      status: widget.task.status,
    );
    taskProvider.updateTask(widget.task, updatedTask);
    setState(() {
      isEditing = false;
      widget.task = updatedTask;
    });
  }

  void toggleCompleted() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.toggleTaskCompletion(widget.task);
    setState(() {});
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

  double getOpacity(String priority) {
    if (priority.toLowerCase() == widget.task.priority.toLowerCase()) {
      return 1.0;
    }
    return 0.1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardGradientColorSecond,
      appBar: CustomAppBar(
        title: '',
        leadingIcon: 'assets/icons/short_left.svg',
        leadingIconColor: AppColors.backgroundColor,
        bgColor: AppColors.cardGradientColorSecond,
        iconColor: AppColors.backgroundColor,
        showLeadingIcon: true,
        showActionIcon: true,
        actionIconAsset: 'assets/icons/edit.svg',
        onActionPressed: toggleEditing,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isEditing
                    ? TextFormField(
                        controller: _nameController,
                        maxLength: 50,
                        autofocus: isEditing,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          counterStyle: TextStyle(color: Colors.white),
                        ),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the task name';
                          }
                          return null;
                        },
                      )
                    : Text(
                        widget.task.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: AppColors.backgroundColor,
                        ),
                      ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                color: AppColors.backgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          'Due Date',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Color(0xFFBFC8E8),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        isEditing
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: Text(
                                      DateFormat.yMMMd().format(_selectedDate),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Divider(
                                    thickness: 0.7,
                                    color: isEditing
                                        ? Colors.black
                                        : const Color(0xFFBFC8E8),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat.yMMMd().format(widget.task.date),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: isEditing ? 14 : 18,
                                  ),
                                  const Divider(
                                    thickness: 0.7,
                                    color: Color(0xFFBFC8E8),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Color(0xFFBFC8E8)),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        isEditing
                            ? TextFormField(
                                controller: _descriptionController,
                                maxLength: 250,
                                maxLines: null,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a description';
                                  }
                                  return null;
                                },
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.task.description,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: AppColors.secondaryColor),
                                  ),
                                  SizedBox(
                                    height: isEditing ? 14 : 18,
                                  ),
                                  const Divider(
                                    thickness: 0.7,
                                    color: Color(0xFFBFC8E8),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          'Priority',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Color(0xFFBFC8E8),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        isEditing
                            ? DropdownButtonFormField<String>(
                                value: _selectedPriority,
                                items: <String>[
                                  'Low',
                                  'Medium',
                                  'High'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedPriority = newValue!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a priority';
                                  }
                                  return null;
                                },
                              )
                            : Row(
                                children: [
                                  ChipWidget(
                                    label: 'low',
                                    backgroundColor: AppColors.lowPriorityColor,
                                    backgroundOpacity: getOpacity('low'),
                                  ),
                                  ChipWidget(
                                    label: 'medium',
                                    backgroundColor:
                                        AppColors.mediumPriorityColor,
                                    backgroundOpacity: getOpacity('medium'),
                                  ),
                                  ChipWidget(
                                    label: 'high',
                                    backgroundColor:
                                        AppColors.highPriorityColor,
                                    backgroundOpacity: getOpacity('high'),
                                  )
                                ],
                              ),
                        const SizedBox(
                          height: 56,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: DynamicButton(
                                  label: isEditing
                                      ? 'Discard'
                                      : widget.task.isCompleted
                                          ? 'Mark as Incomplete'
                                          : 'Mark as Completed',
                                  onPressed: isEditing
                                      ? toggleEditing
                                      : toggleCompleted,
                                ),
                              ),
                              Expanded(
                                child: DynamicButton(
                                  label: isEditing ? 'Save' : 'Delete Task',
                                  backgroundColor: isEditing
                                      ? AppColors.secondaryColor
                                      : const Color(0xFFff6347),
                                  onPressed: isEditing ? saveTask : deleteTask,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
