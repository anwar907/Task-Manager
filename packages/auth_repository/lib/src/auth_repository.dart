import 'package:supabase_repository/supabase_repository.dart';

class AuthRepositoryException implements Exception {
  final Exception exception;
  final StackTrace stackTrace;

  AuthRepositoryException(this.exception, this.stackTrace);
}

class SigninException extends AuthRepositoryException {
  SigninException(super.exception, super.stackTrace);
}

class SignUpException extends AuthRepositoryException {
  SignUpException(super.exception, super.stackTrace);
}

class SignOutException extends AuthRepositoryException {
  SignOutException(super.exception, super.stackTrace);
}

class AuthRepository {
  final SupabaseApiClient _supabaseRepository;

  AuthRepository({required SupabaseApiClient supabaseRepository})
    : _supabaseRepository = supabaseRepository;

  Future<String?> signIn(String email, String password) async {
    try {
      final response = await _supabaseRepository.signIn(email, password);
      return response.session?.accessToken;
    } on Exception catch (e, stackTrace) {
      throw SigninException(e, stackTrace);
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
    } on Exception catch (e, stackTrace) {
      throw SignUpException(e, stackTrace);
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseRepository.signOut();
    } on Exception catch (e, stackTrace) {
      throw SignOutException(e, stackTrace);
    }
  }
}
