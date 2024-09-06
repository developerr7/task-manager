import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/constants/app_colors.dart';
import 'package:tasky_app/providers/task_provider.dart';
import 'package:tasky_app/widgets/action_card_widget.dart';
import 'package:tasky_app/widgets/app_bar_widget.dart';
import 'package:tasky_app/widgets/banner_card_widget.dart';
import 'package:tasky_app/widgets/card_widget.dart';
import 'package:tasky_app/widgets/chip_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _navigateToPreferenceScreen(BuildContext context) {
    Navigator.pushNamed(context, '/preference');
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(
        title: '',
        actionIcon: Icons.settings,
        onActionPressed: () => _navigateToPreferenceScreen(context),
        bgColor: AppColors.primaryColor,
        iconColor: const Color(0xFF324646),
        showLeadingIcon: false,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.45,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hello, Rushi!',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Opacity(
                        opacity: 0.54,
                        child: Text(
                          'Have a nice day.',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.secondaryColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          ChipWidget(
                            label: 'today',
                            backgroundColor: AppColors.backgroundColor,
                            backgroundOpacity: 1,
                          ),
                          ChipWidget(
                            label: 'tommorow',
                            backgroundColor: Color(0xFFE5EAFC),
                            backgroundOpacity: 1,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: CountCard(
                                  title: 'Total task',
                                  count: taskProvider.totalTaskCount(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: CountCard(
                                  title: 'Completed task',
                                  count: taskProvider.completedTaskCount(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Actions',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      SizedBox(height: 18),
                      ActionCard(
                        logo: 'assets/images/todo.svg',
                        primaryText: 'View all the priority tasks for today',
                        logoHeight: 64,
                        logoWidth: 64,
                      ),
                      BannerCard(
                        primaryText: 'Elevate Your Task Game with Tasky!',
                        logo: 'assets/icons/arrow-right.svg',
                        logoWidth: 64,
                        logoHeight: 64,
                        backgroundImage: 'assets/images/bg.svg',
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
