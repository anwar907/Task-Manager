import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_repository/supabase_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:willdo/app/app_routes.dart';
import 'package:willdo/app/modules/splash/cubit/splash_cubit.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required SupabaseApiRepository supabaseApiRepository,
    required AuthRepository authRepository,
    required TaskRepository taskRepository,
  }) : _supabaseApiRepository = supabaseApiRepository,
       _taskRepository = taskRepository,
       _authRepository = authRepository;

  final SupabaseApiRepository _supabaseApiRepository;
  final AuthRepository _authRepository;
  final TaskRepository _taskRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SupabaseApiRepository>(
          create: (context) => _supabaseApiRepository,
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => _authRepository,
        ),
        RepositoryProvider<TaskRepository>(
          create: (context) => _taskRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider<SplashCubit>(create: (_) => SplashCubit())],
        child: MaterialApp(
          title: 'Task Manager',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.root,
          routes: AppRoutes.routes(),
        ),
      ),
    );
  }
}
