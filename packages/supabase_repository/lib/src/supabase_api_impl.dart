import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_repository/src/models/task_model.dart';
import 'package:supabase_repository/src/supabase_api_client.dart';

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
  Future<TaskModel> createTask(TaskModel taskModel) async {
    try {
      final response = await _supabase.from('tasks').insert(taskModel.toJson());
      return TaskModel.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
