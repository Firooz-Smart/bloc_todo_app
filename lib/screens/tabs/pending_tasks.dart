import 'package:bloc_todo/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc_exports.dart';
import '../../models/task.dart';

class PendingTasks extends StatelessWidget {
  const PendingTasks({super.key});
  static const id = 'pending_tasks_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.pendingTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                  label: Text(
                      '${state.completedTasks.length} Completed | ${state.pendingTasks.length} Pending Tasks')),
            ),
            TasksList(
              tasks: tasksList,
            )
          ],
        );
      },
    );
  }
}
