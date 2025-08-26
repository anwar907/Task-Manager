import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_repository/storage_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthState()) {
    on<AuthEventLogin>(_signIn);
  }

  final AuthRepository _authRepository;

  Future<void> _signIn(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _authRepository.signIn(event.email, event.password);
      await PereferenceHelper().save('token', user);

      emit(state.copyWith(status: AuthStatus.success, message: 'Success'));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: 'Failure'));
    }
  }
}
