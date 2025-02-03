import 'package:flutter/material.dart';
import '../models/pessoa.dart';
import '../repositories/pessoa_repository.dart';

class PessoaProvider with ChangeNotifier {
  final PessoaRepository repository;
  List<Pessoa> _pessoas = [];

  PessoaProvider(this.repository);

  List<Pessoa> get pessoas => _pessoas;

  Future<void> fetchPessoas() async {
    _pessoas = await repository.fetchPessoas();
    notifyListeners();
  }
}
