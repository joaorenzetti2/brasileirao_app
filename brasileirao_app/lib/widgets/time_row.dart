import 'package:brasileirao_app/models/time.dart';
import 'package:flutter/material.dart';

class TimeRow extends StatelessWidget {
  final Time time;
  final int index;

  const TimeRow({super.key, required this.time, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${index + 1}'),
      title: Text(time.nome),
      subtitle: Row(
        children: [
          Text('${time.pontos} pts'),
          const SizedBox(
            width: 10,
          ),
          Text('${time.numjogos} jogos'),
        ],
      ),
    );
  }
}
