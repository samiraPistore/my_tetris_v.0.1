import 'package:flutter/material.dart';

class Scorelist extends StatelessWidget {
  final List<String> ranking;

  const Scorelist({super.key, required this.ranking});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'POSIÇÃO',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'JOGADOR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'PONTUAÇÃO',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ranking.length,
              itemBuilder: (context, index) {
                final parts = ranking[index].split('|');
            
                return Container(
  padding: const EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 8,
  ),
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(),
    ),
  ),
  child: Row(
    children: [
      Expanded(
        flex: 1,
        child: Text('${index + 1}º'),
      ),

      Expanded(
        flex: 3,
        child: Text(parts[0]),
      ),

      Expanded(
        flex: 2,
        child: Text(
          '${parts[1]} pts',
          textAlign: TextAlign.end,
        ),
      ),
    ],
  ),

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
