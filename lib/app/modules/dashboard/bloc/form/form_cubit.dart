import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_repository/supabase_repository.dart';
import 'package:task_repository/task_repository.dart';

part 'form_state.dart';

class FormCubit extends Cubit<TaskFormState> {
  FormCubit({required TaskRepository taskRepository})
    : _taskRepository = taskRepository,
      super(const TaskFormState());

  final TaskRepository _taskRepository;

  String _convertDateFormat(String dateString) {
    try {
      final parts = dateString.split('-');
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2];
        return '$year-$month-$day';
      }
      return dateString;
    } catch (e) {
      return dateString;
    }
  }

  Future<void> saveTask(
    String title,
    String description,
    String dueDate,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    try {
      final taskModel = TaskModel(
        title: title,
        description: description,
        dueDate: _convertDateFormat(dueDate),
      );

      _taskRepository.createTask(taskModel);

      emit(
        state.copyWith(isLoading: false, isSuccess: true, errorMessage: null),
      );

      // Reset form after successful save
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(const TaskFormState());
      });
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
          isSuccess: false,
        ),
      );
    }
  }

  Future<void> updateTask(
    String id,
    String title,
    String description,
    String dueDate,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    try {
      final taskModel = TaskModel(
        id: id,
        title: title,
        description: description,
        dueDate: _convertDateFormat(dueDate),
      );

      await _taskRepository.updateTask(taskModel);

      emit(
        state.copyWith(isLoading: false, isSuccess: true, errorMessage: null),
      );

      // Reset form after successful update
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(const TaskFormState());
      });
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
          isSuccess: false,
        ),
      );
    }
  }

  void selectDate(DateTime dateTime) {
    emit(state.copyWith(dateTime: dateTime));
  }
}
