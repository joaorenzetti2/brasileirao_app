import 'dart:convert';
import 'package:brasileirao_app/models/rodada.dart';
import 'package:brasileirao_app/models/time.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:4004';
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Time>> getTimes() async {
    final response = await client.get(Uri.parse('$baseUrl/times'));
    if (response.statusCode == 200) {
      final List<dynamic> timesJson = jsonDecode(response.body);
      return timesJson.map((json) => Time.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar times.');
    }
  }

  Future<void> addTime(Time time) async {
    final response = await client.post(Uri.parse('$baseUrl/times'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(time.toJson()));
    if (response.statusCode != 201) {
      throw Exception('Erro ao acionar times.');
    }
  }

  Future<void> updateTime(Time time) async {
    final response = await client.put(Uri.parse('$baseUrl/times'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(time.toJson()));
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar times.');
    }
  }

  Future<void> deleteTime(Time time) async {
    final response =
        await client.delete(Uri.parse('$baseUrl/times/${time.id}'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar time.');
    }
  }

  Future<List<Rodada>> fetchRodadas() async {
    final response = await http.get(Uri.parse('$baseUrl/rodadas'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Rodada.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar rodadas');
    }
  }
}
