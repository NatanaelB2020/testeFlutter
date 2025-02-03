import 'package:flutter/material.dart';

class PessoaDetailScreen extends StatelessWidget {
  final String nome;

  const PessoaDetailScreen({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(nome)),
      body: Center(child: Text("Detalhes de $nome")),
    );
  }
}
