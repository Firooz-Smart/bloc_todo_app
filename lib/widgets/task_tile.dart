import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.only(left: 10),
        title: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.star_border)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        decoration: task.isDone!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat().add_yMMMd().add_Hms().format(DateTime.now()),
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              Checkbox(
                onChanged: !task.isDeleted!
                    ? (v) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                      }
                    : null,
                value: task.isDone,
                activeColor: Theme.of(context).primaryColorLight,
              ),
              PopupMenuButton(
                itemBuilder: (context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () {},
                      padding: EdgeInsets.zero,
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                        label: Text('Edit'),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => removeOrDeleteTask(context, task),
                      padding: EdgeInsets.zero,
                      child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.delete),
                        label: Text('Delete'),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {},
                      padding: EdgeInsets.zero,
                      child: TextButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.star_border),
                        label: const Text('Add to bookmark'),
                      ),
                    ),
                  ];
                },
              )
            ],
          ),
        ),
        onLongPress: () => removeOrDeleteTask(context, task));
  }
}
