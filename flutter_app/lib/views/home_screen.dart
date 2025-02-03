import 'package:flutter/material.dart';
import 'package:flutter_app/views/candidatos_por_estados_screen.dart';
import 'package:flutter_app/views/doadores_por_tipo_sanguineo_screen.dart';
import 'package:flutter_app/views/faixa_etaria_imc_screen.dart';
import 'package:flutter_app/views/percentual_obesos_screen.dart';
import 'package:flutter_app/views/pessoa_form_screen.dart';

class HomeScreen extends StatelessWidget {
  final String token;

  const HomeScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Banco de Sangue')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(context, "Salvar Pessoa", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PessoaFormScreen(token: token),
                ),
              );
            }),
            _buildCard(context, "Candidatos por Estado", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidatosPorEstadoScreen(token: token),
                ),
              );
            }),
            _buildCard(context, "Faixa Etária IMC", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FaixaEtariaImcScreen(token: token),
                ),
              );
            }),
            _buildCard(context, "Percentual de Obesos", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PercentualObesosScreen(token: token),
                ),
              );
            }),
            _buildCard(context, "Doadores por Tipo Sanguíneo", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoadoresPorTipoSanguineoScreen(token: token),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
