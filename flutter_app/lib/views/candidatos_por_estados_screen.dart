import 'package:flutter/material.dart';
import 'package:flutter_app/services/pessoa_service.dart';

class CandidatosPorEstadoScreen extends StatelessWidget {
  final String token; // Agora passamos o token corretamente
  final PessoaService _pessoaService;

  CandidatosPorEstadoScreen({required this.token, Key? key})
      : _pessoaService = PessoaService(token), // Agora funciona corretamente
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Candidatos por Estado')),
      body: FutureBuilder<Map<String, int>>(
        future: _pessoaService.fetchCandidatosPorEstado(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final candidatosPorEstado = snapshot.data!;

          return ListView.builder(
            itemCount: candidatosPorEstado.length,
            itemBuilder: (context, index) {
              final estado = candidatosPorEstado.keys.elementAt(index);
              final count = candidatosPorEstado[estado];

              return ListTile(
                title: Text(estado),
                subtitle: Text('Quantidade: $count'),
              );
            },
          );
        },
      ),
    );
  }
}
