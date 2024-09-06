import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/constants/app_colors.dart';
import 'package:tasky_app/constants/enum.dart';
import 'package:tasky_app/providers/task_provider.dart';
import 'package:tasky_app/screens/single_task_screen.dart';
import 'package:tasky_app/widgets/app_bar_widget.dart';
import 'package:tasky_app/widgets/date_picker_widget.dart';
import 'package:tasky_app/widgets/floating_button_widget.dart';
import 'package:tasky_app/widgets/task_list_card_widget.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  DateTime? selectedDate = DateTime.now();
  SortOption _selectedSortOption = SortOption.noSort;

  void searchFunction() {}

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void onSortChanged(SortOption? option) {
    if (option != null) {
      setState(() {
        _selectedSortOption = option;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks =
        taskProvider.getSortedTasks(_selectedSortOption, date: selectedDate);

    return Scaffold(
      backgroundColor: AppColors.cardGradientColorSecond,
      appBar: CustomAppBar(
        title: '',
        leadingIcon: 'assets/icons/short_left.svg',
        leadingIconColor: AppColors.backgroundColor,
        actionIconAsset: 'assets/icons/search.svg',
        onActionPressed: searchFunction,
        bgColor: AppColors.cardGradientColorSecond,
        iconColor: AppColors.backgroundColor,
        showLeadingIcon: true,
      ),
      floatingActionButton: const CustomFloatingButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MMM, yyyy').format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 35,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: AppColors.backgroundColor,
                  ),
                ),
                const SizedBox(height: 20),
                HorizontalDatePicker(
                  onDateSelected: onDateSelected,
                  selectedDate: selectedDate,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                color: AppColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: tasks.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/missing.svg',
                              height: 140,
                              width: 140,
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Tasks',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                  DropdownButton<SortOption>(
                                    value: _selectedSortOption,
                                    icon: const Icon(Icons.sort),
                                    onChanged: onSortChanged,
                                    items: SortOption.values
                                        .map((SortOption option) {
                                      return DropdownMenuItem<SortOption>(
                                        value: option,
                                        child: Text(option ==
                                                SortOption.byStatus
                                            ? 'Sort by Status'
                                            : option == SortOption.byPriority
                                                ? 'Sort by Priority'
                                                : 'No Sort'),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: tasks.length,
                                  itemBuilder: (context, index) {
                                    final task = tasks[index];
                                    return Dismissible(
                                      key: ValueKey(task),
                                      onDismissed: (direction) =>
                                          {taskProvider.removeTask(task)},
                                      child: TaskListCard(
                                        primaryText: task.name,
                                        priority: task.priority,
                                        isCompleted: task.isCompleted,
                                        secondaryText: task.description,
                                        onToggleCompleted: () => taskProvider
                                            .toggleTaskCompletion(task),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SingleTaskScreen(
                                                task: task,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
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
