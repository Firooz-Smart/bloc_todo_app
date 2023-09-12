import 'package:bloc_todo/screens/edit_task_screen.dart';
import 'package:bloc_todo/widgets/popup_menu.dart';
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

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(
            oldTask: task,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10),
      title: Row(
        children: [
          IconButton(
              onPressed: null,
              icon: Icon(
                task.isFavorite! ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColorLight,
              )),
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
                  DateFormat()
                      .add_yMMMd()
                      .add_Hms()
                      .format(DateTime.parse(task.date)),
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
            PopupMenu(
              task: task,
              removeOrDeleteCallBack: () => removeOrDeleteTask(context, task),
              likeOrDislikeCallBack: () {
                context
                    .read<TasksBloc>()
                    .add(MarkFavoriteOrUnFavoriteTask(task: task));
              },
              editCallBack: () {
                Navigator.pop(context);
                _editTask(context);
              },
              restoreCallBack: () =>
                  context.read<TasksBloc>().add(RestoreTask(task: task)),
            )
          ],
        ),
      ),
    );
  }
}
