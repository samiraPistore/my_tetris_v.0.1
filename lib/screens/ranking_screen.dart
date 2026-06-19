import 'package:flutter/material.dart';
import 'package:my_tetris_1/components/btn_shape.dart';
import 'package:my_tetris_1/components/score_list.dart';
import 'package:my_tetris_1/services/score_service.dart';

class Rankingpage extends StatefulWidget {
  const Rankingpage({super.key});

  @override
  State<Rankingpage> createState() => _RankingpageState();
}

class _RankingpageState extends State<Rankingpage> {
  //instância do service
  final rankingService = RankingService();

  //lista local armazenar informações ranking
  List<String> ranking = [];

  @override
  void initState() {
    super.initState();
    loadRanking();
  }

  Future<void> loadRanking() async {
    ranking = await rankingService.loadScores();

    ranking.sort((a, b) {
      final scoreA = int.parse(a.split('|')[1]);
      final scoreB = int.parse(b.split('|')[1]);

      return scoreB.compareTo(scoreA);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'RANKING PONTUAÇÕES',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2),
                      ),
                      child: Scorelist(ranking: ranking),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: BtnShape(
                    text: 'VOLTAR PARA HOME',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
