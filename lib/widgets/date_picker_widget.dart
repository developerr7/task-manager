import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/constants/app_colors.dart';

class HorizontalDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? selectedDate;

  const HorizontalDatePicker({
    Key? key,
    required this.onDateSelected,
    this.selectedDate,
  }) : super(key: key);

  @override
  _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  final DateTime startDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30,
        itemBuilder: (context, index) {
          final date = startDate.add(Duration(days: index));
          final isSelected = date.year == widget.selectedDate?.year &&
              date.month == widget.selectedDate?.month &&
              date.day == widget.selectedDate?.day;

          return GestureDetector(
            onTap: () {
              widget.onDateSelected(date);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Card(
                color: isSelected
                    ? AppColors.darkThemeBackgroundColor
                    : AppColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 1,
                child: Container(
                  width: 70,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E').format(date),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        DateFormat('d').format(date),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
