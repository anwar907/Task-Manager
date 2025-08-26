part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupEventSubmit extends SignupEvent {
  final String email;
  final String password;
  final String username;

  const SignupEventSubmit(this.email, this.password, this.username);

  @override
  List<Object> get props => [email, password, username];
}
