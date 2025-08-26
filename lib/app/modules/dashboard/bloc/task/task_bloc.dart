import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_repository/supabase_repository.dart';
import 'package:task_repository/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({required TaskRepository taskRepository})
    : _taskRepository = taskRepository,
      super(TaskState()) {
    on<FetchTasks>(_fetchTasks);
    on<FilterTasks>(_filterTasks);
    on<DeleteTask>(_deleteTask);
  }

  final TaskRepository _taskRepository;

  Future<void> _fetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      final tasks = await _taskRepository.getTasks();

      emit(state.copyWith(tasks: tasks, status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: 'Failure'));
    }
  }

  Future<void> _filterTasks(FilterTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      final tasks = await _taskRepository.filterTasks(event.isCompleted);

      emit(state.copyWith(tasks: tasks, status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: 'Failure'));
    }
  }

  Future<void> _deleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.deleteTask(event.taskId);
      add(FetchTasks());
      emit(state.copyWith(status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: 'Failure'));
    }
  }
}
