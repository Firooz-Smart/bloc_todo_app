import 'package:bloc_todo/blocs/bloc/tasks_bloc.dart';
import 'package:bloc_todo/blocs/bloc/tasks_event.dart';
import 'package:bloc_todo/blocs/bloc/tasks_state.dart';
import 'package:bloc_todo/widgets/tasks_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

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
        List<Task> tasksList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: Text('Tasks App'),
            actions: [
              IconButton(
                  onPressed: () => _addTask(context), icon: Icon(Icons.add))
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(label: Text('${state.allTasks.length} Tasks')),
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
