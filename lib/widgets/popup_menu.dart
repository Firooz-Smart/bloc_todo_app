import 'package:bloc_todo/blocs/bloc_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback removeOrDeleteCallBack;
  final VoidCallback likeOrDislikeCallBack;
  final VoidCallback editCallBack;
  final VoidCallback restoreCallBack;
  const PopupMenu({
    super.key,
    required this.task,
    required this.removeOrDeleteCallBack,
    required this.likeOrDislikeCallBack,
    required this.editCallBack,
    required this.restoreCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: !task.isDeleted!
          ? (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: editCallBack,
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: editCallBack,
                      icon: Icon(Icons.edit),
                      label: Align(
                        child: Text('Edit'),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: removeOrDeleteCallBack,
                  padding: EdgeInsets.zero,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                  ),
                ),
                PopupMenuItem(
                  onTap: likeOrDislikeCallBack,
                  padding: EdgeInsets.zero,
                  child: TextButton.icon(
                    onPressed: null,
                    icon:
                        Icon(task.isFavorite! ? Icons.star : Icons.star_border),
                    label: Text(!task.isFavorite!
                        ? 'Add to bookmark'
                        : 'Remove from bookmark'),
                  ),
                ),
              ]
          : (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: () {},
                  padding: EdgeInsets.zero,
                  child: TextButton.icon(
                    onPressed: restoreCallBack,
                    icon: Icon(Icons.restore_from_trash_outlined),
                    label: Text('Restore'),
                  ),
                ),
                PopupMenuItem(
                  onTap: removeOrDeleteCallBack,
                  padding: EdgeInsets.zero,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.delete),
                    label: Text('Delete forever'),
                  ),
                ),
              ],
    );
  }
}
