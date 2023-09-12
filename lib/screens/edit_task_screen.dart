import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../blocs/bloc_exports.dart';

class EditTaskScreen extends StatefulWidget {
  final Task oldTask;
  const EditTaskScreen({super.key, required this.oldTask});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController txtTitle;
  late TextEditingController txtDescription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    txtTitle = TextEditingController(text: widget.oldTask.title);
    txtDescription = TextEditingController(text: widget.oldTask.description);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('Edit Task'),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: txtTitle,
            autofocus: true,
            decoration: InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: txtDescription,
            autofocus: true,
            decoration: InputDecoration(
              label: Text('Description'),
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
            maxLength: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    if (txtTitle.text.isNotEmpty) {
                      context.read<TasksBloc>().add(
                            EditTask(
                                newTask: widget.oldTask.copyWith(
                                    title: txtTitle.text,
                                    description: txtDescription.text,
                                    isDone: false,
                                    date: DateTime.now().toString()),
                                oldTask: widget.oldTask),
                          );
                      txtTitle.clear();
                      txtDescription.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save')),
            ],
          )
        ],
      ),
    );
  }
}
