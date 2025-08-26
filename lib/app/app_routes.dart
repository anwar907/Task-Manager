import 'package:flutter/material.dart';
import 'package:willdo/app/modules/dashboard/dashboard_page.dart';
import 'package:willdo/app/modules/login/login_page.dart';
import 'package:willdo/app/modules/splash/splash_screen.dart';

class AppRoutes {
  static const String root = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes() {
    return {
      root: (context) => SplashScreen(),
      login: (context) => LoginPage(),
      dashboard: (context) => DashboardPage(),
    };
  }
}
