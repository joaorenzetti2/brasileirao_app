import 'package:flutter/material.dart';
import 'package:brasileirao_app/models/time.dart';
import 'package:brasileirao_app/services/api_service.dart';

class FormularioEditarScreen extends StatefulWidget {
  final Time time;

  FormularioEditarScreen({required this.time});

  @override
  _FormularioEditarScreenState createState() => _FormularioEditarScreenState();
}

class _FormularioEditarScreenState extends State<FormularioEditarScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _pontosController;
  late TextEditingController _numJogosController;

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os dados do time
    _nomeController = TextEditingController(text: widget.time.nome);
    _pontosController =
        TextEditingController(text: widget.time.pontos.toString());
    _numJogosController =
        TextEditingController(text: widget.time.numjogos.toString());
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _pontosController.dispose();
    _numJogosController.dispose();
    super.dispose();
  }

  // Função para salvar as alterações no time
  void _salvarAlteracoes() async {
    if (_formKey.currentState!.validate()) {
      final timeAlterado = Time(
        id: widget.time.id,
        nome: _nomeController.text,
        pontos: int.parse(_pontosController.text),
        numjogos: int.parse(_numJogosController.text),
      );

      final apiService = ApiService();
      await apiService.updateTime(timeAlterado);

      Navigator.pop(context,
          timeAlterado); // Retorna o time atualizado para a tela anterior
    }
  }

  // Função para remover o time
  void _removerTime() async {
    final confirmacao = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text(
              'Você tem certeza que deseja excluir o time "${widget.time.nome}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmacao == true) {
      final apiService = ApiService();
      await apiService.deleteTime(widget.time);
      Navigator.pop(context); // Retorna para a tela inicial após excluir
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Time'),
      ),
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
                onPressed: _salvarAlteracoes,
                child: Text('Salvar Alterações'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: _removerTime,
                child: Text(
                  'Excluir Time',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
