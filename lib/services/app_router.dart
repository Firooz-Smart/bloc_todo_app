import 'package:bloc_todo/screens/home_screen.dart';
import 'package:bloc_todo/screens/recycle_bin.dart';
import 'package:bloc_todo/screens/tasks_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case TasksScreen.id:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RecycleBin.id:
        return MaterialPageRoute(
          builder: (context) => const RecycleBin(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
  }
}
