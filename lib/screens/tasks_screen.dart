import '../blocs/bloc_exports.dart';

import 'package:bloc_todo/screens/app_drawer.dart';
import 'package:bloc_todo/widgets/tasks_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});
  static const id = 'tasks_screen';

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
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
            title: Text('Tasks App'),
            actions: [
              IconButton(
                  onPressed: () => _addTask(context), icon: Icon(Icons.add))
            ],
          ),
          drawer: const AppDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(label: Text('${state.pendingTasks.length} Tasks')),
              ),
              TasksList(
                tasks: tasksList,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addTask(context);
            },
            child: Icon(CupertinoIcons.add),
          ),
        );
      },
    );
  }
}
