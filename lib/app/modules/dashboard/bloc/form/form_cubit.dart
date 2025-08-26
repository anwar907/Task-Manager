import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_repository/supabase_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:willdo/app/utils/task_status.dart';

part 'form_state.dart';

class FormCubit extends Cubit<TaskFormState> {
  FormCubit({required TaskRepository taskRepository})
    : _taskRepository = taskRepository,
      super(const TaskFormState());

  final TaskRepository _taskRepository;

  Future<void> saveTask(
    String title,
    String description,
    String dueDate,
  ) async {
    emit(state.copyWith(errorMessage: null, status: FormStatus.loading));

    try {
      final taskModel = TaskModel(
        title: title,
        description: description,
        dueDate: dueDate.toDbFormat(),
      );

      await _taskRepository.createTask(taskModel);

      emit(state.copyWith(status: FormStatus.success, errorMessage: 'Success'));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failure', status: FormStatus.failure));
    }
  }

  Future<void> updateTask(TaskModel task) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      await _taskRepository.updateTask(task);

      emit(state.copyWith(errorMessage: 'Success', status: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failure', status: FormStatus.failure));
    }
  }

  void selectDate(DateTime dateTime) {
    // clear previouse date time
    if (state.selectedDate != null) {
      emit(state.copyWith(dateTime: null));
    }
    emit(state.copyWith(dateTime: dateTime));
  }

  void resetState() {
    emit(const TaskFormState());
  }
}
