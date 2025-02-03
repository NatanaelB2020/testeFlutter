import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  // Método para salvar o token
  void setToken(String token) {
    _token = token;
    notifyListeners();  // Notifica todas as dependências que o token foi alterado
  }

  // Método para limpar o token (Logout)
  void logout() {
    _token = null;
    notifyListeners();
  }
}
