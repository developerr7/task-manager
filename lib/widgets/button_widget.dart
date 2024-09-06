import 'package:flutter/material.dart';

class DynamicButton extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color backgroundColor;
  final IconData? icon;
  final bool showIcon;
  final double height;
  final VoidCallback? onPressed; // Callback for button action

  const DynamicButton({
    super.key,
    required this.label,
    this.labelColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.icon,
    this.showIcon = false,
    this.height = 64,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: backgroundColor,
        elevation: 1,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showIcon && icon != null) Icon(icon, color: labelColor),
                if (showIcon && icon != null) const SizedBox(width: 8),
                Text(
                  label,
                  maxLines: 2,
                  style: TextStyle(
                    color: labelColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
