import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_repository/supabase_repository.dart';

class AuthMock extends Mock implements SupabaseApiClient {}

void main() {
  final supabase = AuthMock();
  final authRepository = AuthRepository(supabaseRepository: supabase);

  group('Login User', () {
    test('should throw Exception on failure', () async {
      when(() => supabase.signIn('', '')).thenThrow(Exception('Failure'));

      await expectLater(
        authRepository.signIn('', ''),
        throwsA(isA<SigninException>()),
      );
    });

    test('should return access token on success', () async {
      final mockResponse = AuthResponse(
        session: Session(
          accessToken: 'test_token',
          tokenType: 'bearer',
          user: User(
            id: 'user_id',
            appMetadata: {},
            userMetadata: {},
            aud: 'authenticated',
            createdAt: DateTime.now().toIso8601String(),
          ),
        ),
      );

      when(
        () => supabase.signIn('test@email.com', 'password'),
      ).thenAnswer((_) async => mockResponse);

      final result = await authRepository.signIn('test@email.com', 'password');
      expect(result, 'test_token');
    });
  });

  group('Sign Up User', () {
    test('should throw Exception on failure', () async {
      when(() => supabase.signUp('', '', '')).thenThrow(Exception('Failure'));

      await expectLater(
        authRepository.signUp('', '', ''),
        throwsA(isA<SignUpException>()),
      );
    });

    test('should return access token on success', () async {
      when(() => supabase.signUp('name', 'email', 'password')).thenAnswer(
        (_) async => AuthResponse(
          session: Session(
            tokenType: 'bearer',
            user: User(
              id: 'user_id',
              appMetadata: {},
              userMetadata: {},
              aud: '',
              createdAt: '',
            ),
            accessToken: 'token',
          ),
        ),
      );
      final result = await authRepository.signUp('name', 'email', 'password');
      expect(result, 'token');
    });
  });
}
