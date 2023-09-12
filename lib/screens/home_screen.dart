import 'package:bloc_todo/screens/tabs/completed_tasks.dart';
import 'package:bloc_todo/screens/tabs/favorite_tasks.dart';
import 'package:bloc_todo/screens/tabs/pending_tasks.dart';

import '../blocs/bloc_exports.dart';

import 'package:bloc_todo/screens/app_drawer.dart';
import 'package:bloc_todo/widgets/tasks_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {"pageName": const PendingTasks(), "pageTitle": "Pending Tasks"},
    {"pageName": const CompletedTasks(), "pageTitle": "Completed Tasks"},
    {"pageName": const FavoriteTasks(), "pageTitle": "Favorite Tasks"},
  ];

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.pendingTasks;
        return Scaffold(
          appBar: AppBar(
            title: Text(pages[selectedIndex]['pageTitle']),
            actions: selectedIndex == 0
                ? [
                    IconButton(
                        onPressed: () => _addTask(context),
                        icon: const Icon(Icons.add))
                  ]
                : null,
          ),
          drawer: const AppDrawer(),
          body: pages[selectedIndex]['pageName'],
          floatingActionButton: selectedIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    _addTask(context);
                  },
                  child: const Icon(CupertinoIcons.add),
                )
              : null,
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.incomplete_circle_outlined),
                  label: 'Pending'),
              NavigationDestination(
                  icon: Icon(Icons.done_all_outlined), label: 'Completed'),
              NavigationDestination(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
            ],
            onDestinationSelected: (i) {
              setState(() {
                selectedIndex = i;
              });
            },
          ),
        );
      },
    );
  }
}
