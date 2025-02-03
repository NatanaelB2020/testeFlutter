import 'pessoa.dart';

class PessoaResponse {
  final List<Pessoa> pessoas;

  PessoaResponse({required this.pessoas});

  /// Método fromJson corrigido
  factory PessoaResponse.fromJson(List<dynamic> json) {
    return PessoaResponse(
      pessoas: json.map((e) => Pessoa.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
