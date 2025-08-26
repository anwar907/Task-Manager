part of 'task_bloc.dart';

enum TaskStatus { initial, loading, success, failure }

class TaskState extends Equatable {
  const TaskState({
    this.tasks = const [],
    this.status = TaskStatus.initial,
    this.message,
  });

  final List<TaskModel> tasks;
  final TaskStatus status;
  final String? message;
  TaskState copyWith({
    List<TaskModel>? tasks,
    TaskStatus? status,
    String? message,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [tasks, status, message];
}
