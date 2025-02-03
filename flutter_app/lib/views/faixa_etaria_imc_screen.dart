import 'package:flutter/material.dart';
import 'package:flutter_app/services/pessoa_service.dart';


class FaixaEtariaImcScreen extends StatelessWidget {
  final String token; // Agora passamos o token corretamente
  final PessoaService _pessoaService;

  FaixaEtariaImcScreen({required this.token, Key? key})
      : _pessoaService = PessoaService(token), // Agora funciona corretamente
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faixa Etária e IMC')),
      body: FutureBuilder<Map<int, double>>(
        future: _pessoaService.fetchFaixaEtariaAndImcMedio(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final faixaEtariaAndImc = snapshot.data!;

          return ListView.builder(
            itemCount: faixaEtariaAndImc.length,
            itemBuilder: (context, index) {
              final faixaEtaria = faixaEtariaAndImc.keys.elementAt(index);
              final imcMedio = faixaEtariaAndImc[faixaEtaria];

              return ListTile(
                title: Text('Faixa Etária: $faixaEtaria'),
                subtitle: Text('IMC Médio: ${imcMedio?.toStringAsFixed(1)}'),
              );
            },
          );
        },
      ),
    );
  }
}
