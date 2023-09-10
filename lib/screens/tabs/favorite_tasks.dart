import 'package:bloc_todo/widgets/tasks_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc_exports.dart';
import '../../models/task.dart';

class FavoriteTasks extends StatelessWidget {
  const FavoriteTasks({super.key});
  static const id = 'favorite_tasks_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.favoriteTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(label: Text('${state.favoriteTasks.length} Tasks')),
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
