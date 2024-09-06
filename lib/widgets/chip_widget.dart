import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final double backgroundOpacity;

  const ChipWidget({
    Key? key,
    required this.label,
    this.backgroundColor = Colors.white,
    this.backgroundOpacity = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
          child: FilterChip(
            backgroundColor: backgroundColor.withOpacity(backgroundOpacity),
            label: Text(label),
            onSelected: (_) {},
            side: BorderSide.none,
          ),
        ),
      ],
    );
  }
}
