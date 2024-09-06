import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/providers/navigation_provider.dart';
import 'package:tasky_app/widgets/bottom_navbar_widget.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final bool showBottomNavBar;

  const BaseScreen({
    super.key,
    required this.child,
    this.showBottomNavBar = true,
  });

  void _onItemTapped(BuildContext context, int index) {
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);

    if (navigationProvider.selectedIndex != index) {
      navigationProvider.updateIndex(index);

      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/task');
          break;
        case 2:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        Provider.of<NavigationProvider>(context).selectedIndex;

    return Scaffold(
      body: child,
      bottomNavigationBar: showBottomNavBar
          ? CustomBottomNavBar(
              selectedIndex: selectedIndex,
              onItemTapped: (index) => _onItemTapped(context, index),
            )
          : null,
    );
  }
}
