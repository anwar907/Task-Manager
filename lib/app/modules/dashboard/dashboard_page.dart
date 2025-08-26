import 'package:flutter/material.dart';
import 'package:willdo/app/app_routes.dart';

class DashboardPage extends StatelessWidget {
  static const routeName = AppRoutes.dashboard;
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: ListView.builder(
        itemCount: 20,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => SizedBox(child: Text('Task $index')),
      ),
    );
  }
}
