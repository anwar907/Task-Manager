import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(SignupState()) {
    on<SignupEventSubmit>(_signup);
  }

  final AuthRepository _authRepository;

  Future<void> _signup(
    SignupEventSubmit event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(status: SignupStatus.loading));
    try {
      await _authRepository.signUp(event.email, event.password, event.username);

      emit(state.copyWith(status: SignupStatus.success, messsage: 'Success'));
    } catch (e) {
      emit(
        state.copyWith(status: SignupStatus.failure, messsage: e.toString()),
      );
    }
  }
}
