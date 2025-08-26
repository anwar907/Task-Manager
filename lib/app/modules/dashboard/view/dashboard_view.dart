import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:willdo/app/modules/dashboard/bloc/task/task_bloc.dart';
import 'package:willdo/app/modules/dashboard/view/task_form.dart';
import 'package:willdo/app/utils/task_status.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Manager'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.filter_list),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 0, child: Text('Completed')),
              const PopupMenuItem(value: 1, child: Text('Not Completed')),
            ],
            onSelected: (value) {
              if (value == 0) {
                context.read<TaskBloc>().add(FilterTasks(true));
              } else if (value == 1) {
                context.read<TaskBloc>().add(FilterTasks(false));
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: context.read<TaskBloc>()..add(FetchTasks()),
        buildWhen: (previous, current) => previous.tasks != current.tasks,
        builder: (context, state) {
          if (state.status == TaskStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == TaskStatus.success) {
            return RefreshIndicator(
              child: ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    onTap: () {
                      showAdaptiveDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            TaskFormView(taskToEdit: state.tasks[index]),
                      ).then((value) {
                        if (!value) return;
                        if (!context.mounted) return;
                        context.read<TaskBloc>().add(FetchTasks());
                      });
                    },
                    leading: IconButton(
                      onPressed: () {
                        context.read<TaskBloc>().add(
                          DeleteTask(state.tasks[index].id ?? ''),
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                    title: Text(state.tasks[index].title),
                    subtitle: Text(state.tasks[index].description),
                    trailing: Text(
                      state.tasks[index].dueDate.getTaskStatus(
                        state.tasks[index].isCompleted ?? false,
                      ),
                    ),
                  ),
                ),
              ),
              onRefresh: () {
                return Future(() {
                  context.read<TaskBloc>().add(FetchTasks());
                });
              },
            );
          }

          if (state.status == TaskStatus.failure) {
            return Center(child: Text(state.message ?? ''));
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAdaptiveDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => TaskFormView(),
          ).then((value) {
            if (!value) return;
            if (!context.mounted) return;
            context.read<TaskBloc>().add(FetchTasks());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
