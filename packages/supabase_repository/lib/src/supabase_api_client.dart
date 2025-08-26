import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_repository/supabase_repository.dart';

abstract class SupabaseApiClient {
  Future<User?> getCurrentUser();
  Future<AuthResponse> signIn(String email, String password);
  Future<void> signOut();
  Future<AuthResponse> signUp(String email, String password, String username);
  Future<TaskModel> createTask(TaskModel taskModel);
}
