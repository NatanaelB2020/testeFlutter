import 'dart:convert';
import 'package:flutter_app/core/network/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<http.Response> _authenticatedRequest(String url, String method, {Map<String, dynamic>? body}) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception("Token não encontrado. Faça login novamente.");
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    if (method == 'POST') {
      return await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
    } else if (method == 'GET') {
      return await http.get(Uri.parse(url), headers: headers);
    } else {
      throw Exception("Método HTTP não suportado");
    }
  }

  Future<http.Response> salvarPessoas(Map<String, dynamic> dados) async {
    return await _authenticatedRequest(Endpoints.salvarPessoas, 'POST', body: dados);
  }

  Future<http.Response> salvarUmaPessoa(Map<String, dynamic> dados) async {
    return await _authenticatedRequest(Endpoints.salvarUmaPessoa, 'POST', body: dados);
  }

  Future<http.Response> candidatosPorEstado() async {
    return await _authenticatedRequest(Endpoints.candidatosPorEstado, 'GET');
  }

  Future<http.Response> faixaEtariaImc() async {
    return await _authenticatedRequest(Endpoints.faixaEtariaImc, 'GET');
  }

  Future<http.Response> percentualObesos() async {
    return await _authenticatedRequest(Endpoints.percentualObesos, 'GET');
  }

  Future<http.Response> doadoresPorTipoSanguineo() async {
    return await _authenticatedRequest(Endpoints.doadoresPorTipoSanguineo, 'GET');
  }

  Future<http.Response> candidatosPorEstadoEspecifico(String estado) async {
    return await _authenticatedRequest("${Endpoints.candidatosPorEstado}/$estado", 'GET');
  }
}
