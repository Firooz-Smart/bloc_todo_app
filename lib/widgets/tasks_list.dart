import '../blocs/bloc_exports.dart';

import 'package:bloc_todo/widgets/task_tile.dart';
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
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
            elevation: 1,
            animationDuration: Duration(milliseconds: 300),
            dividerColor: Theme.of(context).primaryColor.withOpacity(0.5),
            children: tasks
                .map(
                  (task) => ExpansionPanelRadio(
                    value: task.id,
                    headerBuilder: (context, isExpanded) {
                      return TaskTile(
                        task: task,
                      );
                    },
                    body: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 15),
                        child: SelectableText.rich(
                            TextSpan(text: task.description)),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}
