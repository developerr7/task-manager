import 'package:flutter/material.dart';
import 'package:tasky_app/constants/app_colors.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  void _navigateToCreateTaskScreen(BuildContext context) {
    Navigator.pushNamed(context, '/task-create');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: FloatingActionButton(
        backgroundColor: AppColors.darkThemeBackgroundColor,
        onPressed: () => _navigateToCreateTaskScreen(context),
        tooltip: 'Add task',
        child: const Icon(
          Icons.add,
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }
}
