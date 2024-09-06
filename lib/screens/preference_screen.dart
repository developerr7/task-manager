import 'package:flutter/material.dart';
import 'package:tasky_app/constants/app_colors.dart';
import 'package:tasky_app/widgets/app_bar_widget.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardGradientColorSecond,
        appBar: CustomAppBar(
          title: 'Preferences',
          leadingIcon: 'assets/icons/short_left.svg',
          leadingIconColor: AppColors.backgroundColor,
          onActionPressed: () {},
          bgColor: AppColors.cardGradientColorSecond,
          iconColor: AppColors.backgroundColor,
          showLeadingIcon: true,
          showActionIcon: false,
        ),
        body: const SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [],
          ),
        ));
  }
}
