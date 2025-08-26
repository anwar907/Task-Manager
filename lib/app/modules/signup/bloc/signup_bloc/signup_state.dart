part of 'signup_bloc.dart';

enum SignupStatus { initial, loading, success, failure }

class SignupState extends Equatable {
  const SignupState({this.messsage, this.status = SignupStatus.initial});

  final String? messsage;
  final SignupStatus status;

  SignupState copyWith({String? messsage, SignupStatus? status}) {
    return SignupState(
      messsage: messsage ?? this.messsage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [messsage, status];
}
