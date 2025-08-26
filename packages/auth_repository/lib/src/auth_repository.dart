import 'package:supabase_repository/supabase_repository.dart';

class AuthRepository {
  final SupabaseApiClient _supabaseRepository;

  AuthRepository({required SupabaseApiClient supabaseRepository})
    : _supabaseRepository = supabaseRepository;

  Future<String?> signIn(String email, String password) async {
    try {
      final response = await _supabaseRepository.signIn(email, password);
      return response.session?.accessToken;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> signUp(String email, String password, String username) async {
    try {
      final response = await _supabaseRepository.signUp(
        email,
        password,
        username,
      );
      return response.session?.accessToken;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseRepository.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
