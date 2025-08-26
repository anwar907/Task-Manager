part of 'form_cubit.dart';

enum FormStatus { initial, loading, success, failure }

class TaskFormState extends Equatable {
  final DateTime? selectedDate;
  final FormStatus status;
  final String? errorMessage;

  const TaskFormState({
    this.selectedDate,
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  TaskFormState copyWith({
    DateTime? dateTime,
    FormStatus? status,
    String? errorMessage,
  }) {
    return TaskFormState(
      selectedDate: dateTime ?? selectedDate,
      errorMessage: errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [selectedDate, errorMessage, status];
}
