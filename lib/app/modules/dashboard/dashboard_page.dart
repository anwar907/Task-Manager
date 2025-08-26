import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:willdo/app/app_routes.dart';
import 'package:willdo/app/modules/dashboard/bloc/form/form_cubit.dart';
import 'package:willdo/app/modules/dashboard/bloc/task/task_bloc.dart';
import 'package:willdo/app/modules/dashboard/view/dashboard_view.dart';

class DashboardPage extends StatelessWidget {
  static const routeName = AppRoutes.dashboard;
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FormCubit(taskRepository: context.read<TaskRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              TaskBloc(taskRepository: context.read<TaskRepository>()),
        ),
      ],
      child: DashboardView(),
    );
  }
}
