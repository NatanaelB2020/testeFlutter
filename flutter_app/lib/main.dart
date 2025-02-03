import 'package:flutter/material.dart';
import 'package:flutter_app/core/network/auth_provider.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'views/home_screen.dart';
import 'views/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'Gestão de Pessoas',
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'Poppins', // Fonte customizada
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
        home: FutureBuilder<bool>(
          future: _isAuthenticated(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return snapshot.data == true
                  ? const HomeScreen(token: '',)
                  : const LoginScreen();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _isAuthenticated() async {
    final token = await AuthService().getToken(); // Get the token from the service
    return token != null && token.isNotEmpty; // Check if token is valid
  }
}

class CustomTitle extends StatelessWidget {
  final String title;

  const CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double fontSize = constraints.maxWidth > 600 ? 32 : 24;
          return Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: fontSize),
          );
        },
      ),
    );
  }
}
