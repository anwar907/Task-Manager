import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:supabase_repository/supabase_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:willdo/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PereferenceHelper().init();

  final supabase = await SupabaseRepositoryFactory.create();
  final authRepository = AuthRepository(supabaseRepository: supabase);
  final taskRepository = TaskRepository(supabaseApiRepository: supabase);

  runApp(
    App(
      authRepository: authRepository,
      supabaseApiRepository: supabase,
      taskRepository: taskRepository,
    ),
  );
}
