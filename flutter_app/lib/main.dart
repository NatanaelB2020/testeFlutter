import 'package:flutter/material.dart';
import 'package:flutter_app/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/views/login_screen.dart';
import 'package:flutter_app/views/home_screen.dart';


void main() {
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),  // Agora você pode usar ChangeNotifierProvider
      child: MaterialApp(
        title: 'Gestão de Pessoas',
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.black54,
            ),
            labelLarge: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        initialRoute: '/login',
        routes: AppRoutes.routes,
      ),
    );
  }
}
