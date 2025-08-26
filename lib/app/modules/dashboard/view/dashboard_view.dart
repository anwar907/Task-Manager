import 'package:flutter/material.dart';
import 'package:willdo/app/modules/dashboard/view/task_form.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => SizedBox(child: Text('Task $index')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAdaptiveDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => TaskFormView(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
