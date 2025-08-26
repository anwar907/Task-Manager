import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:willdo/app/app_routes.dart';
import 'package:willdo/app/modules/dashboard/dashboard_page.dart';
import 'package:willdo/app/modules/login/login_page.dart';
import 'package:willdo/app/modules/splash/cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = AppRoutes.root;
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<SplashCubit, SplashState>(
          bloc: SplashCubit()..sessionAuth(),
          listener: (context, state) {
            if (state.isLogin == false) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            }
          },
          child: const SafeArea(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
