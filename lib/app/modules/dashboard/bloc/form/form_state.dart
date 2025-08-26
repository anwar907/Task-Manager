part of 'form_cubit.dart';

class TaskFormState extends Equatable {
  final DateTime? selectedDate;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const TaskFormState({
    this.selectedDate,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  TaskFormState copyWith({
    DateTime? dateTime,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return TaskFormState(
      selectedDate: dateTime ?? selectedDate,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [selectedDate, isLoading, errorMessage, isSuccess];
}
