import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'http://localhost:8080/api/pessoas';

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
