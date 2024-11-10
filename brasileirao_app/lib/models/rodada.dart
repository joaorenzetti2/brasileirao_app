class Rodada {
  final int id;
  final int numrodada;
  final String time1;
  final String time2;

  Rodada({
    required this.id,
    required this.numrodada,
    required this.time1,
    required this.time2,
  });

  factory Rodada.fromJson(Map<String, dynamic> json) {
    return Rodada(
      id: int.parse(json['id'].toString()), // Garantir que é int
      numrodada: int.parse(json['numrodada'].toString()), // Garantir que é int
      time1: json['time1'],
      time2: json['time2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numrodada': numrodada,
      'time1': time1,
      'time2': time2,
    };
  }
}
