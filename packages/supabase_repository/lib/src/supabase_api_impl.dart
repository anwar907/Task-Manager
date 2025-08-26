import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_repository/src/models/task_model.dart';
import 'package:supabase_repository/src/supabase_api_client.dart';
import 'package:uuid/uuid.dart';

class SupabaseRepositoryFactory {
  final _supabase = Supabase.instance.client;

  SupabaseClient get publicClient => _supabase;

  static Future<SupabaseApiRepository> create() async {
    const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
    const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      throw Exception('SUPABASE_URL or SUPABASE_ANON_KEY is empty');
    }

    final supabase = await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: kDebugMode,
      authOptions: FlutterAuthClientOptions(autoRefreshToken: true),
      storageOptions: StorageClientOptions(retryAttempts: 3),
    );
    return SupabaseApiRepository(supabase.client);
  }
}

class SupabaseApiRepository implements SupabaseApiClient {
  SupabaseApiRepository(this._supabase);
  final SupabaseClient _supabase;
  @override
  Future<User?> getCurrentUser() {
    try {
      final user = _supabase.auth.currentUser;
      return Future.value(user);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signOut() {
    try {
      final response = _supabase.auth.signOut();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AuthResponse> signUp(
    String email,
    String password,
    String username,
  ) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username, 'email': email},
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> createTask(TaskModel taskModel) async {
    try {
      final data = TaskModel(
        userId: _supabase.auth.currentUser?.id ?? '',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        title: taskModel.title,
        description: taskModel.description,
        dueDate: taskModel.dueDate,
        id: Uuid().v4(),
        isCompleted: false,
      );

      final response = await _supabase.from('tasks').insert(data.toJson());
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await _supabase
          .from('tasks')
          .select()
          .eq('id', _supabase.auth.currentUser?.id ?? '');
      return response.map((e) => TaskModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TaskModel>> filterTasks(bool isCompleted) async {
    try {
      final response = await _supabase
          .from('tasks')
          .select()
          .eq('is_completed', isCompleted);
      return response.map((e) => TaskModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateTask(TaskModel taskModel) async {
    try {
      final response = await _supabase
          .from('tasks')
          .update(taskModel.toJson())
          .eq('id', taskModel.id ?? '');
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
