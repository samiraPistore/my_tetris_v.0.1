import 'package:flutter/material.dart';
import 'package:my_tetris_1/components/btnShape.dart';
import 'package:my_tetris_1/components/gameGrid.dart';
import 'package:my_tetris_1/controllers/logic_controller.dart';

class Gamepage extends StatefulWidget {
  const Gamepage({super.key});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  late GameController controller;

  @override
  void initState() {
    super.initState();

    controller = GameController(
      onUpdate: () {
        if (mounted) setState(() {});
      },
      onGameOver: (score) => finishGame(score),
    );

    controller.startGameCountdown();
  }

  void finishGame(int score) {
    controller.stop();

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Partida Encerrada'),
          content: Text('Pontuação: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // fecha dialog
                Navigator.pop(context); // volta tela
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.startCount == 0
                    ? "VAI!"
                    : "${controller.startCount}",
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('PONTUAÇÃO'),

              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.76,
                color: Theme.of(context).colorScheme.secondary,
                child: Center(child: Text('${controller.score} pts')),
              ),

              Expanded(
                child: GameGrid(
                  currentPiece: controller.currentPiece,
                  board: controller.board,
                ),
              ),


              BtnShape(text: 'ENCERRAR', onPressed: () => finishGame(controller.score),)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }
}
