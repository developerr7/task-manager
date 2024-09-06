import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  Color _getIconColor(int index) {
    return selectedIndex == index
        ? AppColors.cardGradientColorSecond
        : const Color(0xFFD8DEF3);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          tooltip: 'Home',
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            colorFilter: ColorFilter.mode(_getIconColor(0), BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          tooltip: 'Calendar',
          icon: SvgPicture.asset(
            'assets/icons/calendar.svg',
            colorFilter: ColorFilter.mode(_getIconColor(1), BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          tooltip: 'Notification',
          icon: SvgPicture.asset(
            'assets/icons/notification.svg',
            colorFilter: ColorFilter.mode(_getIconColor(2), BlendMode.srcIn),
            height: 24,
            width: 24,
          ),
          label: '',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: AppColors.cardGradientColorSecond,
      unselectedItemColor: const Color(0xFFD8DEF3),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    );
  }
}
