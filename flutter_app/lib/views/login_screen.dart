import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/views/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLogin = true;
  String? _errorMessage;

  void _authenticate() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = "Preencha todos os campos");
      return;
    }

    bool success;
    if (_isLogin) {
      success = await _authService.login(username, password);
      if (success) {
        String? token = await _authService.getToken();
        if (token != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(token: token)),
          );
        } else {
          setState(() => _errorMessage = "Erro ao recuperar o token");
        }
      } else {
        setState(() => _errorMessage = "Usuário ou senha inválidos");
      }
    } else {
      success = await _authService.register(username, password);
      if (success) {
        setState(() {
          _isLogin = true;
          _errorMessage = "Registro bem-sucedido! Faça login.";
        });
      } else {
        setState(() => _errorMessage = "Erro ao registrar usuário");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? "Login" : "Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Usuário"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text(_isLogin ? "Entrar" : "Registrar"),
            ),
            TextButton(
              onPressed: () => setState(() => _isLogin = !_isLogin),
              child: Text(_isLogin ? "Criar uma conta" : "Já tenho uma conta"),
            ),
          ],
        ),
      ),
    );
  }
}
