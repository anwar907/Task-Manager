part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class FetchTasks extends TaskEvent {
  const FetchTasks();
}

final class FilterTasks extends TaskEvent {
  final bool isCompleted;
  const FilterTasks(this.isCompleted);
}

final class FilterTasksByStatus extends TaskEvent {
  final String status;
  const FilterTasksByStatus(this.status);
  
  @override
  List<Object> get props => [status];
}


final class DeleteTask extends TaskEvent {
  final String taskId;
  const DeleteTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}