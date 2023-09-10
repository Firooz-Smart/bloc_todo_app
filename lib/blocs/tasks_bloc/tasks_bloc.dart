import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../bloc_exports.dart';
import '../../models/task.dart';

class TasksBloc extends HydratedBloc<TaskEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_addTask);
    on<UpdateTask>(_updateTask);
    on<DeleteTask>(_deleteTask);
    on<RemoveTask>(_removeTask);
  }

  void _addTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      removedTasks: state.removedTasks,
    ));
  }

  void _updateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    !task.isDone!
        ? {
            pendingTasks = List<Task>.from(pendingTasks)..remove(task),
            completedTasks = List<Task>.from(completedTasks)
              ..add(task.copyWith(isDone: true)),
          }
        : {
            completedTasks = List<Task>.from(completedTasks)..remove(task),
            pendingTasks = List<Task>.from(pendingTasks)
              ..add(task.copyWith(isDone: false)),
          };

    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _deleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> tasks = List.from(state.pendingTasks)..remove(event.task);
    List<Task> removedTasks = List.from(state.removedTasks)..remove(event.task);
    emit(TasksState(
        pendingTasks: tasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: removedTasks));
  }

  void _removeTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> removedTasks = List.from(state.removedTasks)
      ..add(event.task.copyWith(isDeleted: true));
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: removedTasks,
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) => TasksState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(TasksState state) => state.toMap();
}
