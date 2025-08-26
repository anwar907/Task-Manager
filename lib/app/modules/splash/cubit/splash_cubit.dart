import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_repository/storage_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState(isLogin: false));

  Future<void> sessionAuth() async {
    final user = await PereferenceHelper().read('token');
    if (user == null) {
      emit(state.copyWith(isLogin: false));
    } else {
      emit(state.copyWith(isLogin: true));
    }
  }
}
