import 'package:brasileirao_app/screens/form_add_screen.dart';
import 'package:brasileirao_app/screens/form_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:brasileirao_app/models/time.dart';
import 'package:brasileirao_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Time> times = [];

  @override
  void initState() {
    super.initState();
    _fetchTimes();
  }

  // Método para buscar os times
  Future<void> _fetchTimes() async {
    final apiService = ApiService();
    final fetchedTimes = await apiService.getTimes();
    setState(() {
      times = fetchedTimes;
    });
  }

  // Método para navegar ao formulário de edição e passar o time para a tela
  void _navigateToEditForm(Time time) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioEditarScreen(
            time: time), // Passando o time para o formulário de edição
      ),
    );
  }

  // Método para navegar para a tela de adicionar time
  void _navigateToAddForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioAdicionarScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brasileirão App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('Próxima Rodada'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/proximaRodada');
              },
            ),
            ListTile(
              title: Text('Adicionar Time'),
              onTap: () {
                Navigator.pushReplacementNamed(context,
                    '/formularioAdicionar'); // Navega para a tela de adicionar time
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView.separated(
          itemCount: times.length,
          itemBuilder: (context, index) {
            final time = times[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${index + 1}. ${time.nome}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Pontos: ${time.pontos}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        'Jogos: ${time.numjogos}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _navigateToEditForm(
                        time), // Passando o time para a tela de edição
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 1,
          ),
        ),
      ),
    );
  }
}
