import 'package:flutter/material.dart';
import 'package:flutter_app/views/login_screen.dart';
import '../views/home_screen.dart';

class AppRoutes {
  static const home = '/home';
  static const login = '/login';

  // Directly define the routes map here
  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(token: '',),
    login: (context) => const LoginScreen(),
  };
}

