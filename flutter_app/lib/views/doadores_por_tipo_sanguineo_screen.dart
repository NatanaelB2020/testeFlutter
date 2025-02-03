
import 'package:flutter/material.dart';
import 'package:flutter_app/services/pessoa_service.dart';


class DoadoresPorTipoSanguineoScreen extends StatelessWidget {
  final String token; // Agora passamos o token corretamente
  final PessoaService _pessoaService;

  DoadoresPorTipoSanguineoScreen({required this.token, Key? key})
      : _pessoaService = PessoaService(token), // Agora funciona corretamente
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doadores por Tipo Sanguíneo')),
      body: FutureBuilder<Map<String, int>>(
        future: _pessoaService.fetchDoadoresPorTipoSanguineo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final doadoresPorTipo = snapshot.data!;

          return ListView.builder(
            itemCount: doadoresPorTipo.length,
            itemBuilder: (context, index) {
              final tipo = doadoresPorTipo.keys.elementAt(index);
              final quantidade = doadoresPorTipo[tipo];

              return ListTile(
                title: Text('Tipo Sanguíneo: $tipo'),
                subtitle: Text('Quantidade de Doadores: $quantidade'),
              );
            },
          );
        },
      ),
    );
  }
}
