import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../models/task.dart';

class TasksState extends Equatable {
  final List<Task> allTasks;
  const TasksState({this.allTasks = const []});
  @override
  // TODO: implement props
  List<Object?> get props => [allTasks];

  Map<String, dynamic> toMap() {
    return {'allTasks': allTasks.map((x) => x.toMap()).toList()};
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        allTasks: List<Task>.from(map['allTasks'].map((x) => Task.fromMap(x))));
  }

  // String toJson() => jsonEncode(toMap());
  // factory TasksState.fromJson(source) => TasksState.fromMap(jsonDecode(source));
}
