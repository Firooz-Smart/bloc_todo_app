import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../blocs/bloc_exports.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController txtTitle = TextEditingController();

  final TextEditingController txtDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('Add Task'),
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
                            AddTask(
                              task: Task(
                                  id: const Uuid().v4(),
                                  title: txtTitle.text,
                                  description: txtDescription.text),
                            ),
                          );
                      txtTitle.clear();
                      txtDescription.clear();
                      print('added');
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add')),
            ],
          )
        ],
      ),
    );
  }
}
