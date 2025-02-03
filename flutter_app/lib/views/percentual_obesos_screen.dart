import 'package:flutter/material.dart';
import 'package:flutter_app/services/pessoa_service.dart';


class PercentualObesosScreen extends StatelessWidget {
  final String token; // Agora passamos o token corretamente
  final PessoaService _pessoaService;

  PercentualObesosScreen({required this.token, Key? key})
      : _pessoaService = PessoaService(token), // Agora funciona corretamente
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Percentual de Obesos')),
      body: FutureBuilder<Map<String, double>>(
        future: _pessoaService.fetchPercentualObesosPorSexo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final percentualObesosPorSexo = snapshot.data!;

          return ListView.builder(
            itemCount: percentualObesosPorSexo.length,
            itemBuilder: (context, index) {
              final sexo = percentualObesosPorSexo.keys.elementAt(index);
              final percentual = percentualObesosPorSexo[sexo];

              return ListTile(
                title: Text('Sexo: $sexo'),
                subtitle: Text('Percentual de Obesos: ${percentual?.toStringAsFixed(1)}%'),
              );
            },
          );
        },
      ),
    );
  }
}
