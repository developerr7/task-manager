import 'package:flutter/material.dart';
import 'package:tasky_app/constants/app_colors.dart';

class CountCard extends StatelessWidget {
  final String title;
  final int count;

  const CountCard({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.88,
        child: Card(
          elevation: 2,
          color: AppColors.cardGradientColorSecond,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 42,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                    color: AppColors.backgroundColor,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
