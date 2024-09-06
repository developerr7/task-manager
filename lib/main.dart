import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/providers/navigation_provider.dart';
import 'package:tasky_app/providers/task_provider.dart';
import 'package:tasky_app/screens/base_screen.dart';
import 'package:tasky_app/screens/home_screen.dart';
import 'package:tasky_app/screens/preference_screen.dart';
import 'package:tasky_app/screens/splash_screen.dart';
import 'package:tasky_app/screens/task_create_screen.dart';
import 'package:tasky_app/screens/task_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (ctx) => const SplashScreen(),
        '/': (ctx) => const BaseScreen(
              showBottomNavBar: true,
              child: HomeScreen(),
            ),
        '/task': (ctx) => const BaseScreen(
              showBottomNavBar: true,
              child: TaskListScreen(),
            ),
        '/task-create': (ctx) => const TaskCreateScreen(),
        '/preference': (ctx) => const PreferenceScreen(),
      },
    );
  }
}
