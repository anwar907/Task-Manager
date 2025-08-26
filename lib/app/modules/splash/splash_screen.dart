import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:willdo/app/app_routes.dart';
import 'package:willdo/app/modules/splash/cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = AppRoutes.root;
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..sessionAuth(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state.isLogin) {
              Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
            } else {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            }
          },
          child: const Center(
            child: SafeArea(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
