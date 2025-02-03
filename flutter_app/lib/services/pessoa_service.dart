import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pessoa.dart';

class PessoaService {
  static const String baseUrl = "http://localhost:8080/api/pessoas";
  late final String token;

  // Construtor para aceitar token
  PessoaService(this.token);

  // Método para enviar requisição HTTP GET com cabeçalho de token
  Future<http.Response> _getRequest(String endpoint) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$endpoint"),
      headers: {
        "Authorization": "Bearer $token", // Adiciona o token
      },
    );
    return response;
  }

  // Método para enviar requisição HTTP POST com cabeçalho de token
  Future<http.Response> _postRequest(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Adiciona o token
      },
      body: json.encode(body),
    );
    return response;
  }

  // Método para salvar uma pessoa
  Future<void> salvarPessoa(Pessoa pessoa) async {
    final response = await _postRequest("salvar-uma", {
      "nome": pessoa.nome,
      "cpf": pessoa.cpf,
      "rg": pessoa.rg,
      "data_nasc": pessoa.dataNasc,
      "sexo": pessoa.sexo,
      "mae": pessoa.mae,
      "pai": pessoa.pai,
      "email": pessoa.email,
      "cep": pessoa.cep,
      "endereco": pessoa.endereco,
      "numero": pessoa.numero,
      "bairro": pessoa.bairro,
      "cidade": pessoa.cidade,
      "estado": pessoa.estado,
      "telefone_fixo": pessoa.telefoneFixo,
      "celular": pessoa.celular,
      "altura": pessoa.altura,
      "peso": pessoa.peso,
      "tipo_sanguineo": pessoa.tipoSanguineo,
    });

    if (response.statusCode != 201) {
      throw Exception("Erro ao salvar pessoa");
    }
  }

  // Método para buscar candidatos por estado
  Future<Map<String, int>> fetchCandidatosPorEstado() async {
    final response = await _getRequest("candidatos-por-estado");

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return body.map((key, value) => MapEntry(key, value as int));
    } else {
      throw Exception("Erro ao buscar candidatos por estado");
    }
  }

  // Método para buscar a faixa etária e o IMC médio
  Future<Map<int, double>> fetchFaixaEtariaAndImcMedio() async {
    final response = await _getRequest("faixa-etaria-imc");

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      Map<int, double> faixaEtariaAndImc = {};
      body.forEach((key, value) {
        faixaEtariaAndImc[int.parse(key)] = value.toDouble();
      });
      return faixaEtariaAndImc;
    } else {
      throw Exception("Erro ao buscar faixa etária e IMC médio");
    }
  }

  // Método para buscar o percentual de obesos por sexo
  Future<Map<String, double>> fetchPercentualObesosPorSexo() async {
    final response = await _getRequest("percentual-obesos");

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      Map<String, double> percentualObesosPorSexo = {};
      body.forEach((key, value) {
        percentualObesosPorSexo[key] = value.toDouble();
      });
      return percentualObesosPorSexo;
    } else {
      throw Exception("Erro ao buscar percentual de obesos por sexo");
    }
  }

  // Método para buscar a quantidade de doadores por tipo sanguíneo
  Future<Map<String, int>> fetchDoadoresPorTipoSanguineo() async {
    final response = await _getRequest("doadores-por-tipo-sanguineo");

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      Map<String, int> doadoresPorTipo = {};
      body.forEach((key, value) {
        doadoresPorTipo[key] = value as int;
      });
      return doadoresPorTipo;
    } else {
      throw Exception("Erro ao buscar doadores por tipo sanguíneo");
    }
  }
}
