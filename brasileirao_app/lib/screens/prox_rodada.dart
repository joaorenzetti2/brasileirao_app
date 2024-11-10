import 'dart:convert';
import 'package:brasileirao_app/models/rodada.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProximaRodadaScreen extends StatefulWidget {
  @override
  _ProximaRodadaScreenState createState() => _ProximaRodadaScreenState();
}

class _ProximaRodadaScreenState extends State<ProximaRodadaScreen> {
  Future<List<Rodada>>? futureRodadas;

  Future<List<Rodada>> fetchRodadas() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:4004/rodadas'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Rodada.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar rodada.');
    }
  }

  @override
  void initState() {
    super.initState();
    futureRodadas = fetchRodadas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Próxima Rodada'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
        ),
      ),
      body: FutureBuilder<List<Rodada>>(
        future: futureRodadas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados'));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final rodada = snapshot.data![index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${rodada.time1} x ${rodada.time2}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Rodada: ${rodada.numrodada}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('Nenhuma rodada encontrada'));
          }
        },
      ),
    );
  }
}
