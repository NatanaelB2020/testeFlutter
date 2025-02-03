import '../models/pessoa.dart';
import '../repositories/pessoa_repository.dart';

class PessoaController {
  final PessoaRepository repository;
  List<Pessoa> pessoas = [];

  PessoaController(this.repository);

  Future<void> getPessoas() async {
    pessoas = await repository.fetchPessoas();
  }
}
