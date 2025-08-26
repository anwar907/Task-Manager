import 'package:supabase_repository/supabase_repository.dart';

class TaskRepository {
  final SupabaseApiRepository _supabaseApiRepository;

  TaskRepository({required SupabaseApiRepository supabaseApiRepository})
    : _supabaseApiRepository = supabaseApiRepository;

  void createTask(TaskModel taskModel) {
    try {
      _supabaseApiRepository.createTask(taskModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<TaskModel>> getTasks() async {
    try {
      return await _supabaseApiRepository.getTasks();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<TaskModel>> filterTasks(bool isCompleted) async {
    try {
      return await _supabaseApiRepository.filterTasks(isCompleted);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateTask(TaskModel taskModel) async {
    try {
      await _supabaseApiRepository.updateTask(taskModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
