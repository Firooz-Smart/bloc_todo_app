import 'package:bloc_todo/blocs/bloc/tasks_bloc.dart';
import 'package:bloc_todo/blocs/bloc/tasks_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
              title: Text(task.title),
              trailing: Checkbox(
                onChanged: (v) {
                  context.read<TasksBloc>().add(UpdateTask(task: task));
                },
                value: task.isDone,
              ),
              onLongPress: () =>
                  context.read<TasksBloc>().add(DeleteTask(task: task)));
        },
      ),
    );
  }
}
