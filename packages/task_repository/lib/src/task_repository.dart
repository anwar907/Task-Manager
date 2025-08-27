import 'package:supabase_repository/supabase_repository.dart';

class TaskRepositoryException implements Exception {
  final Exception exception;
  final StackTrace stackTrace;

  TaskRepositoryException(this.exception, this.stackTrace);
}

class CreateTaskException extends TaskRepositoryException {
  CreateTaskException(super.exception, super.stackTrace);
}

class GetTasksException extends TaskRepositoryException {
  GetTasksException(super.exception, super.stackTrace);
}

class UpdateTaskException extends TaskRepositoryException {
  UpdateTaskException(super.exception, super.stackTrace);
}

class DeleteTaskException extends TaskRepositoryException {
  DeleteTaskException(super.exception, super.stackTrace);
}

class FilterTasksException extends TaskRepositoryException {
  FilterTasksException(super.exception, super.stackTrace);
}

class TaskRepository {
  final SupabaseApiRepository _supabaseApiRepository;

  TaskRepository({required SupabaseApiRepository supabaseApiRepository})
    : _supabaseApiRepository = supabaseApiRepository;

  Future<void> createTask(TaskModel taskModel) async {
    try {
      await _supabaseApiRepository.createTask(taskModel);
    } on Exception catch (e, stackTrace) {
      throw CreateTaskException(e, stackTrace);
    }
  }

  Future<List<TaskModel>> getTasks() async {
    try {
      return await _supabaseApiRepository.getTasks();
    } on Exception catch (e, stackTrace) {
      throw GetTasksException(e, stackTrace);
    }
  }

  Future<List<TaskModel>> filterTasks(bool isCompleted) async {
    try {
      return await _supabaseApiRepository.filterTasks(isCompleted);
    } on Exception catch (e, stackTrace) {
      throw FilterTasksException(e, stackTrace);
    }
  }

  Future<void> updateTask(TaskModel taskModel) async {
    try {
      await _supabaseApiRepository.updateTask(taskModel);
    } on Exception catch (e, stackTrace) {
      throw UpdateTaskException(e, stackTrace);
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _supabaseApiRepository.deleteTask(id);
    } on Exception catch (e, stackTrace) {
      throw DeleteTaskException(e, stackTrace);
    }
  }
}
