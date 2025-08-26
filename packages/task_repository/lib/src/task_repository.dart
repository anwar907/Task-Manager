import 'package:supabase_repository/supabase_repository.dart';

class TaskRepository {
  final SupabaseApiRepository _supabaseApiRepository;

  TaskRepository({required SupabaseApiRepository supabaseApiRepository})
    : _supabaseApiRepository = supabaseApiRepository;

  Future<TaskModel> createTask(TaskModel taskModel) {
    try {
      return _supabaseApiRepository.createTask(taskModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
