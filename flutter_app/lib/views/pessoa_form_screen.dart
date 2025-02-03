import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_app/models/pessoa.dart';

class PessoaFormScreen extends StatefulWidget {
  final String token;

  const PessoaFormScreen({super.key, required this.token});

  @override
  _PessoaFormScreenState createState() => _PessoaFormScreenState();
}

class _PessoaFormScreenState extends State<PessoaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  final _cpfMask = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  final _rgMask = MaskTextInputFormatter(mask: '##.###.###-#', filter: {"#": RegExp(r'[0-9]')});
  final _dataNascMask = MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  final _cepMask = MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});
  final _telefoneMask = MaskTextInputFormatter(mask: '(##) ####-####', filter: {"#": RegExp(r'[0-9]')});
  final _celularMask = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  final List<String> tiposSanguineos = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? sexoSelecionado;

  void _salvarPessoa() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final novaPessoa = Pessoa(
        id: 0,
        nome: _formData['nome'],
        cpf: _formData['cpf'],
        rg: _formData['rg'],
        dataNasc: _formData['dataNasc'],
        sexo: _formData['sexo'],
        mae: _formData['mae'],
        pai: _formData['pai'],
        email: _formData['email'],
        cep: _formData['cep'],
        endereco: _formData['endereco'],
        numero: _formData['numero'],
        bairro: _formData['bairro'],
        cidade: _formData['cidade'],
        estado: _formData['estado'],
        telefoneFixo: _formData['telefoneFixo'],
        celular: _formData['celular'],
        altura: _formData['altura'],
        peso: _formData['peso'],
        tipoSanguineo: _formData['tipoSanguineo'],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pessoa salva com sucesso!')),
      );

      _formKey.currentState!.reset();
      setState(() {
        _formData.clear();
        sexoSelecionado = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Pessoa')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField('Nome Completo', 'nome'),
                _buildMaskedField('CPF', 'cpf', _cpfMask),
                _buildMaskedField('RG', 'rg', _rgMask),
                _buildMaskedField('Data de Nascimento', 'dataNasc', _dataNascMask),
                _buildTextField('Nome da Mãe', 'mae'),
                _buildTextField('Nome do Pai', 'pai'),
                _buildTextField('E-mail', 'email', keyboardType: TextInputType.emailAddress),
                _buildMaskedField('CEP', 'cep', _cepMask),
                _buildTextField('Endereço', 'endereco'),
                _buildTextField('Número', 'numero', keyboardType: TextInputType.number),
                _buildTextField('Bairro', 'bairro'),
                _buildTextField('Cidade', 'cidade'),
                _buildTextField('Estado', 'estado'),
                _buildMaskedField('Telefone Fixo', 'telefoneFixo', _telefoneMask),
                _buildMaskedField('Celular', 'celular', _celularMask),
                _buildTextField('Altura (m)', 'altura', keyboardType: TextInputType.number),
                _buildTextField('Peso (kg)', 'peso', keyboardType: TextInputType.number),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Tipo Sanguíneo'),
                  value: _formData['tipoSanguineo'],
                  onChanged: (value) {
                    setState(() {
                      _formData['tipoSanguineo'] = value!;
                    });
                  },
                  items: tiposSanguineos.map((tipo) {
                    return DropdownMenuItem(value: tipo, child: Text(tipo));
                  }).toList(),
                  validator: (value) => value == null ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _salvarPessoa,
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String field, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
      onSaved: (value) => _formData[field] = value!,
    );
  }

  Widget _buildMaskedField(String label, String field, MaskTextInputFormatter mask) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      inputFormatters: [mask],
      validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
      onSaved: (value) => _formData[field] = value!,
    );
  }
}
