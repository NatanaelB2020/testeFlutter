import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String apiUrl = 'http://localhost:8080/auth';

  // Realizar o login
  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      if (token != null) {
        await _saveToken(token);
        return true;
      }
    }
    return false;
  }

  // Realizar o registro
  Future<bool> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'), // Verifique se este endpoint existe no seu backend
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 201) {
      // Registro bem-sucedido
      return true;
    } else {
      // Erro no registro
      return false;
    }
  }

  // Salvar o token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Obter o token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fazer logout e limpar o token
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
