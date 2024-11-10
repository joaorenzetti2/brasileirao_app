import 'package:flutter/material.dart';
import 'package:brasileirao_app/models/time.dart';
import 'package:brasileirao_app/services/api_service.dart';

class FormularioAdicionarScreen extends StatefulWidget {
  @override
  _FormularioAdicionarScreenState createState() =>
      _FormularioAdicionarScreenState();
}

class _FormularioAdicionarScreenState extends State<FormularioAdicionarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _pontosController = TextEditingController();
  final _numJogosController = TextEditingController();

  // Função para salvar o novo time
  void _salvarNovoTime() async {
    if (_formKey.currentState!.validate()) {
      final novoTime = Time(
        id: 0, // Novo time não tem id
        nome: _nomeController.text,
        pontos: int.parse(_pontosController.text),
        numjogos: int.parse(_numJogosController.text),
      );

      final apiService = ApiService();
      await apiService.addTime(novoTime);

      Navigator.pop(
          context, novoTime); // Retorna o novo time para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Adicionar Novo Time'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome do time
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do time';
                  }
                  return null;
                },
              ),
              // Pontos do time
              TextFormField(
                controller: _pontosController,
                decoration: InputDecoration(labelText: 'Pontos'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os pontos';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              // Número de jogos
              TextFormField(
                controller: _numJogosController,
                decoration: InputDecoration(labelText: 'Número de Jogos'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de jogos';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarNovoTime,
                child: Text('Adicionar Time'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
