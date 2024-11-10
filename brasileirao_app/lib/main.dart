import 'package:brasileirao_app/screens/form_add_screen.dart';
import 'package:brasileirao_app/screens/form_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:brasileirao_app/models/time.dart';
import 'package:brasileirao_app/screens/home_screen.dart';
import 'package:brasileirao_app/screens/prox_rodada.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brasileirão App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: '/', // Define a tela inicial
      routes: {
        '/': (context) => HomeScreen(), // Rota para a tela inicial
        '/proximaRodada': (context) => ProximaRodadaScreen(),
        // Rota para adicionar um novo time
        '/formularioAdicionar': (context) => FormularioAdicionarScreen(),
        // Rota para editar um time existente
        '/formularioEditar': (context) => FormularioEditarScreen(
              time: Time(id: 0, nome: 'Novo Time', pontos: 0, numjogos: 0),
            ),
      },
    );
  }
}
