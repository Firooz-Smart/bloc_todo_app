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
