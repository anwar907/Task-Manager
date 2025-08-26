import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:willdo/app/app_routes.dart';
import 'package:willdo/app/modules/login/bloc/auth_bloc/auth_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isFormValid = ValueNotifier<bool>(false);
  void validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    isFormValid.value = isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          onChanged: validateForm,
          child: Column(
            spacing: 20.0,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text('Login to your account'),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(label: Text('Email')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(label: Text('Password')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),

              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.loading) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state.status == AuthStatus.success) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashboard,
                      (route) => false,
                    );
                  }
                  if (state.status == AuthStatus.failure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: ValueListenableBuilder(
                  valueListenable: isFormValid,
                  builder: (context, isValid, _) {
                    return ElevatedButton(
                      onPressed: isValid
                          ? () {
                              context.read<AuthBloc>().add(
                                AuthEventLogin(
                                  email.text,
                                  passwordController.text,
                                ),
                              );
                            }
                          : null,
                      child: const Text('Login'),
                    );
                  },
                ),
              ),
              Align(
                heightFactor: 6,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signup);
                  },
                  child: const Text('Don\'t have an account? Sign up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
