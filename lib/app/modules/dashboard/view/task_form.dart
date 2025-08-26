import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_repository/supabase_repository.dart';
import 'package:willdo/app/modules/dashboard/bloc/form/form_cubit.dart';
import 'package:willdo/app/modules/dashboard/bloc/task/task_bloc.dart';
import 'package:willdo/app/utils/task_status.dart';

class TaskFormView extends StatelessWidget {
  TaskFormView({super.key, this.taskToEdit});

  final TaskModel? taskToEdit;
  final title = TextEditingController();
  final description = TextEditingController();
  final date = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isFormValid = ValueNotifier<bool>(false);

  bool get isEditMode => taskToEdit != null;

  void validateForm() {
    final isNameFilled = title.text.trim().isNotEmpty;
    final isSavingTypeFilled = description.text.trim().isNotEmpty;

    isFormValid.value = isNameFilled && isSavingTypeFilled;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FormCubit>().resetState();
    });

    if (isEditMode && taskToEdit != null) {
      title.text = taskToEdit?.title ?? '';
      description.text = taskToEdit?.description ?? '';
      date.text = taskToEdit?.dueDate.toDbFormat() ?? '';
    }

    return SimpleDialog(
      key: const ValueKey('form_saving_widget_key'),
      elevation: 1,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(isEditMode ? 'Edit Task' : 'Add New Task'),
          InkWell(
            onTap: () => Navigator.pop(context, false),
            child: const Icon(Icons.close),
          ),
        ],
      ),
      children: [
        Container(
          key: const ValueKey('container_key'),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              onChanged: validateForm,
              child: Column(
                key: const ValueKey('form_column_key'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(label: Text('Title')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter task title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: description,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Description'),
                    ),
                  ),

                  BlocConsumer<FormCubit, TaskFormState>(
                    listener: (context, state) {
                      if (state.selectedDate != null) {
                        date.text =
                            '${state.selectedDate?.day}-${state.selectedDate?.month}-${state.selectedDate?.year}';
                      }
                    },
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                            initialDate:
                                state.selectedDate ??
                                date.text.toDateTime() ??
                                DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              if (!context.mounted) return;
                              context.read<FormCubit>().selectDate(value);
                            }
                          });
                        },
                        child: Text(
                          state.selectedDate == null && date.text.isEmpty
                              ? 'Select Date'
                              : date.text.isNotEmpty
                              ? date.text
                              : '${state.selectedDate?.day}-${state.selectedDate?.month}-${state.selectedDate?.year}',
                        ),
                      );
                    },
                  ),

                  ValueListenableBuilder<bool>(
                    valueListenable: isFormValid,
                    builder: (context, isValid, _) {
                      return ElevatedButton(
                        onPressed: isValid
                            ? () {
                                if (isEditMode) {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    context.read<FormCubit>().updateTask(
                                      TaskModel(
                                        id: taskToEdit?.id,
                                        title: title.text,
                                        description: description.text,
                                        isCompleted: taskToEdit?.isCompleted,
                                        userId: taskToEdit?.userId,
                                        createdAt: taskToEdit?.createdAt,
                                        updatedAt: DateTime.now()
                                            .toIso8601String(),
                                        dueDate: date.text.toDbFormat(),
                                      ),
                                    );
                                  }
                                } else {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    context.read<FormCubit>().saveTask(
                                      title.text,
                                      description.text,
                                      date.text,
                                    );
                                  }
                                }
                                context.read<TaskBloc>().add(FetchTasks());
                                Navigator.pop(context, true);
                              }
                            : null,
                        child: const Text('Submit'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
