class Time {
  final int id;
  final String nome;
  final int pontos;
  final int numjogos;

  Time(
      {required this.id,
      required this.nome,
      this.pontos = 0,
      this.numjogos = 0});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      id: int.parse(json['id'].toString()), // Converter para int
      nome: json['nome'],
      pontos: int.parse(json['pontos'].toString()), // Converter para int
      numjogos: int.parse(json['numjogos'].toString()), // Converter para int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'pontos': pontos,
      'numjogos': numjogos,
    };
  }
}
