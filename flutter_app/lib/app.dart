import 'package:flutter/material.dart';
import 'routes/app_routes.dart'; // This should be a Map, not a function
import 'theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Pessoas',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,  // Corrected usage
    );
  }
}
