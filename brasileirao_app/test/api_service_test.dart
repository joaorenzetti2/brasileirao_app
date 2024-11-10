import 'package:flutter_test/flutter_test.dart';
import 'package:brasileirao_app/services/api_service.dart';
import 'package:brasileirao_app/models/time.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Crie uma classe Mock do http.Client
class MockClient extends Mock implements http.Client {}

void main() {
  group('ApiService Tests', () {
    late ApiService apiService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiService = ApiService(client: mockClient);
    });

    test('getTimes should return a list of times', () async {
      // Simula a resposta da API
      final mockResponse = jsonEncode([
        {'id': 1, 'nome': 'Botafogo', 'pontos': 68, 'numjogos': 33},
        {'id': 2, 'nome': 'Palmeiras', 'pontos': 64, 'numjogos': 33}
      ]);

      when(mockClient.get(Uri.parse('http://10.0.2.2:4004/times')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      // Chama a função que queremos testar
      final times = await apiService.getTimes();

      expect(times.length, 2);
      expect(times[0].nome, 'Botafogo');
    });

    test('updateTime should update a time successfully', () async {
      final time = Time(id: 1, nome: 'Botafogo', pontos: 70, numjogos: 34);
      final mockResponse = http.Response('', 200);

      when(mockClient.put(
        Uri.parse('http://10.0.2.2:4004/times/${time.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(time.toJson()),
      )).thenAnswer((_) async => mockResponse);

      await apiService.updateTime(time);

      verify(mockClient.put(
        Uri.parse('http://10.0.2.2:4004/times/${time.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(time.toJson()),
      )).called(1);
    });

    test('deleteTime should delete a time successfully', () async {
      final time = Time(id: 1, nome: 'Botafogo', pontos: 70, numjogos: 34);
      final mockResponse = http.Response('', 200);

      when(mockClient.delete(
        Uri.parse('http://10.0.2.2:4004/times/${time.id}'),
      )).thenAnswer((_) async => mockResponse);

      await apiService.deleteTime(time);

      verify(mockClient.delete(
        Uri.parse('http://10.0.2.2:4004/times/${time.id}'),
      )).called(1);
    });
  });
}
