part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final bool isLogin;

  const SplashState({required this.isLogin});

  SplashState copyWith({bool? isLogin}) {
    return SplashState(isLogin: isLogin ?? this.isLogin);
  }

  @override
  List<Object> get props => [isLogin];
}
