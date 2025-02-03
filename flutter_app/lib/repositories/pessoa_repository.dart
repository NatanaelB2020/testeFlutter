import 'package:flutter_app/models/pessoa_response.dart';

import '../core/network/api_client.dart';
import '../models/pessoa.dart';

class PessoaRepository {
  final ApiClient apiClient;
  PessoaRepository(this.apiClient);

  Future<List<Pessoa>> fetchPessoas() async {
    final response = await apiClient.get('/pessoas');
    return PessoaResponse.fromJson(response).pessoas;
  }
}
