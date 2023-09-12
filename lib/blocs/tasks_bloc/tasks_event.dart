import 'package:equatable/equatable.dart';

import '../../models/task.dart';

class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;
  const AddTask({required this.task});
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;
  const UpdateTask({required this.task});
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;
  const DeleteTask({required this.task});
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class RemoveTask extends TaskEvent {
  final Task task;
  const RemoveTask({required this.task});
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class MarkFavoriteOrUnFavoriteTask extends TaskEvent {
  final Task task;
  const MarkFavoriteOrUnFavoriteTask({required this.task});
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class EditTask extends TaskEvent {
  final Task newTask;
  final Task oldTask;
  const EditTask({required this.newTask, required this.oldTask});
  @override
  // TODO: implement props
  List<Object?> get props => [newTask, oldTask];
}

class RestoreTask extends TaskEvent {
  final Task task;
  const RestoreTask({required this.task});
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class DeleteAllTasks extends TaskEvent {
  const DeleteAllTasks();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
