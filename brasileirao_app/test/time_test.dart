import 'package:flutter_test/flutter_test.dart';
import 'package:brasileirao_app/models/time.dart';

void main() {
  group('Time Model Tests', () {
    test('Time fromJson should create a Time object from JSON', () {
      final json = {'id': 1, 'nome': 'Botafogo', 'pontos': 68, 'numjogos': 33};

      final time = Time.fromJson(json);

      expect(time.id, 1);
      expect(time.nome, 'Botafogo');
      expect(time.pontos, 68);
      expect(time.numjogos, 33);
    });

    test('Time toJson should return a valid JSON map', () {
      final time = Time(id: 1, nome: 'Botafogo', pontos: 68, numjogos: 33);

      final json = time.toJson();

      expect(json['id'], 1);
      expect(json['nome'], 'Botafogo');
      expect(json['pontos'], 68);
      expect(json['numjogos'], 33);
    });
  });
}
