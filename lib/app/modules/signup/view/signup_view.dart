import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:willdo/app/modules/login/login_page.dart';
import 'package:willdo/app/modules/signup/bloc/signup_bloc/signup_bloc.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isFormValid = ValueNotifier<bool>(false);
  void validatedForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    isFormValid.value = isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          onChanged: validatedForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 14.0,

            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text('Sign Up'),
              TextFormField(
                controller: name,

                decoration: const InputDecoration(label: Text('Name')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
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
                controller: password,
                decoration: const InputDecoration(label: Text('Password')),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              BlocListener<SignupBloc, SignupState>(
                listener: (context, state) {
                  if (state.status == SignupStatus.loading) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Loading...')));
                  }
                  if (state.status == SignupStatus.success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }

                  if (state.status == SignupStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.messsage ?? '')),
                    );
                  }
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: isFormValid,
                  builder: (context, isValid, _) {
                    return ElevatedButton(
                      onPressed: isValid
                          ? () {
                              context.read<SignupBloc>().add(
                                SignupEventSubmit(
                                  email.text,
                                  password.text,
                                  name.text,
                                ),
                              );
                            }
                          : null,
                      child: const Text('Sign Up'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
