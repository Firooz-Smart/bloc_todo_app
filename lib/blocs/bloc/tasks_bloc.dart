import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo/blocs/bloc/tasks_event.dart';
import 'package:bloc_todo/blocs/bloc/tasks_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/task.dart';

class TasksBloc extends HydratedBloc<TaskEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_addTask);
    on<UpdateTask>(_updateTask);
    on<DeleteTask>(_deleteTask);
  }

  void _addTask(AddTask event, Emitter<TasksState> emit) {
    print(event.task.id);
    final state = this.state;
    emit(TasksState(allTasks: List.from(state.allTasks)..add(event.task)));
  }

  void _updateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final index = state.allTasks.indexOf(task);

    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    allTasks.insert(index, task.copyWith(isDone: !task.isDone!));
    emit(TasksState(allTasks: allTasks));
  }

  void _deleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> tasks = List.from(state.allTasks)..remove(event.task);
    emit(TasksState(allTasks: tasks));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) => TasksState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(TasksState state) => state.toMap();
}
