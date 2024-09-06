import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/constants/app_colors.dart';
import 'package:tasky_app/providers/task_provider.dart';

class TaskListCard extends StatefulWidget {
  final String primaryText;
  final String secondaryText;
  final String priority;
  final bool isCompleted;
  final VoidCallback onToggleCompleted;
  final VoidCallback onTap;

  const TaskListCard(
      {super.key,
      required this.primaryText,
      required this.secondaryText,
      required this.priority,
      this.isCompleted = false,
      required this.onToggleCompleted,
      required this.onTap});

  @override
  _TaskListCardState createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    Color getPriorityColor() {
      switch (widget.priority.toLowerCase()) {
        case 'high':
          return AppColors.highPriorityColor;
        case 'medium':
          return AppColors.mediumPriorityColor;
        case 'low':
          return AppColors.lowPriorityColor;
        default:
          return Colors.white;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Card(
              color: AppColors.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 5, 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/todo.svg',
                      height: 45,
                      width: 45,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.primaryText,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: widget.isCompleted
                                  ? Colors.grey
                                  : AppColors.secondaryColor,
                              decoration: widget.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.secondaryText,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFFAEAEB3),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 25),
                    GestureDetector(
                      onTap: widget.onToggleCompleted,
                      child: widget.isCompleted
                          ? SvgPicture.asset(
                              'assets/icons/check.svg',
                              height: 30,
                              width: 30,
                              colorFilter: const ColorFilter.mode(
                                Colors.green,
                                BlendMode.srcIn,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/icons/check.svg',
                              height: 30,
                              width: 30,
                              colorFilter: const ColorFilter.mode(
                                Colors.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      child: SizedBox(
                        width: 16,
                        height: 60,
                        child: Card(
                          elevation: 1,
                          color: getPriorityColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
