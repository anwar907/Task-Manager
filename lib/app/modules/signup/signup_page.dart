import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:willdo/app/app_routes.dart';
import 'package:willdo/app/modules/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:willdo/app/modules/signup/view/signup_view.dart';

class SignupPage extends StatelessWidget {
  static const routeName = AppRoutes.signup;
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignupBloc(authRepository: context.read<AuthRepository>()),
      child: SignupView(),
    );
  }
}
