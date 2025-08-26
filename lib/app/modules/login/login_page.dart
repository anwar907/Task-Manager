import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:willdo/app/app_routes.dart';
import 'package:willdo/app/modules/login/bloc/auth_bloc/auth_bloc.dart';
import 'package:willdo/app/modules/login/view/login_view.dart';

class LoginPage extends StatelessWidget {
  static const routeName = AppRoutes.login;
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(authRepository: context.read<AuthRepository>()),
      child: LoginView(),
    );
  }
}
