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
    on<MarkFavoriteOrUnFavoriteTask>(_markFavoriteOrUnFavoriteTask);
    on<EditTask>(_editTask);
    on<RestoreTask>(_restoreTask);
    on<DeleteAllTasks>(_deleteAllTasks);
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
    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isFavorite!) {
      int index = favoriteTasks.indexOf(task);
      favoriteTasks = List<Task>.from(favoriteTasks)
        ..removeAt(index)
        ..insert(index, task.copyWith(isDone: !task.isDone!));
    }

    if (task.isDone!) {
      completedTasks = List<Task>.from(completedTasks)..remove(task);
      pendingTasks = List<Task>.from(pendingTasks)
        ..add(task.copyWith(isDone: false));
    } else {
      pendingTasks = List<Task>.from(pendingTasks)..remove(task);
      completedTasks = List<Task>.from(completedTasks)
        ..add(task.copyWith(isDone: true));
    }

    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
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

  void _markFavoriteOrUnFavoriteTask(
      MarkFavoriteOrUnFavoriteTask event, Emitter<TasksState> emit) {
    var pendingTasks = List<Task>.from(state.pendingTasks);
    var completedTasks = List<Task>.from(state.completedTasks);
    var favoriteTasks = List<Task>.from(state.favoriteTasks);
    Task task = event.task;

    //IF TASK IS IN PENDING LIST
    if (!task.isDone!) {
      int index = pendingTasks.indexOf(task);
      if (!task.isFavorite!) {
        favoriteTasks.add(task.copyWith(isFavorite: true));

        pendingTasks = pendingTasks
          ..removeAt(index)
          ..insert(index, task.copyWith(isFavorite: true));
      } else {
        favoriteTasks.remove(task);

        pendingTasks = pendingTasks
          ..removeAt(index)
          ..insert(index, task.copyWith(isFavorite: false));
      }
    } else {
      int index = completedTasks.indexOf(task);
      if (!task.isFavorite!) {
        favoriteTasks.add(task.copyWith(isFavorite: true));

        completedTasks = completedTasks
          ..removeAt(index)
          ..insert(index, task.copyWith(isFavorite: true));
      } else {
        favoriteTasks.remove(task);

        completedTasks
          ..removeAt(index)
          ..insert(index, task.copyWith(isFavorite: false));
      }
    }

    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _editTask(EditTask event, Emitter<TasksState> emit) {
    Task newTask = event.newTask;
    Task oldTask = event.oldTask;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (oldTask.isFavorite!) {
      favoriteTasks = favoriteTasks
        ..remove(oldTask)
        ..insert(0, newTask);
    }

    if (oldTask.isDone!) {
      completedTasks.remove(oldTask);
    }

    emit(
      TasksState(
          pendingTasks: List<Task>.from(state.pendingTasks)
            ..remove(oldTask)
            ..insert(0, newTask),
          completedTasks: completedTasks,
          favoriteTasks: favoriteTasks,
          removedTasks: state.removedTasks),
    );
  }

  void _restoreTask(RestoreTask event, Emitter<TasksState> emit) {
    Task task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isFavorite!) {
      favoriteTasks.insert(0, task);
    }

    if (task.isDone!) {
      completedTasks.insert(0, task);
    } else {
      pendingTasks.insert(0, task);
    }

    emit(
      TasksState(
          pendingTasks: pendingTasks,
          completedTasks: completedTasks,
          favoriteTasks: favoriteTasks,
          removedTasks: List<Task>.from(state.removedTasks)..remove(task)),
    );
  }

  void _deleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
    emit(TasksState(
        removedTasks: List<Task>.from(state.removedTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) => TasksState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(TasksState state) => state.toMap();
}
