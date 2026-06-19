import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_tetris_1/components/btn_shape.dart';
import 'package:my_tetris_1/components/game_grid.dart';
import 'package:my_tetris_1/controllers/logic_controller.dart';
import 'package:my_tetris_1/services/score_service.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Gamepage extends StatefulWidget {
  final String playerName;

  const Gamepage({super.key, required this.playerName});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  late GameController controller;

  final rankingService = RankingService();

  StreamSubscription? accelerometerSub;

  bool canTiltMove = true;
  bool gameFinished = false;

  @override
  void initState() {
    super.initState();

    _setupController();
    _setupAccelerometer();

    controller.startGameCountdown();
  }

  void _setupController() {
    controller = GameController(
      onUpdate: () {
        if (mounted) setState(() {});
      },
      onGameOver: finishGame,
    );
  }

  void _setupAccelerometer() {
    accelerometerSub = accelerometerEventStream().listen((event) {
      if (!canTiltMove) return;

      if (event.x > 4) {
        controller.movLeft();
        _lockTilt();
      } else if (event.x < -4) {
        controller.movRight();
        _lockTilt();
      }
    });
  }

  void _lockTilt() {
    canTiltMove = false;

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        canTiltMove = true;
      }
    });
  }

  Future<void> finishGame(int score) async {
    if (gameFinished) return;

    gameFinished = true;

    controller.stop();

    await rankingService.saveScore(widget.playerName, score);

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        // Garante que o jogo não fique sob o notch/câmera do celular
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Contador inicial 
              Text(
                controller.startCount == 0
                    ? 'VAI!'
                    : '${controller.startCount}',
                style: const TextStyle(
                  fontSize: 40,
                  color:  Color(0xFF333333),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Painel de Pontuação
              const Text(
                'PONTUAÇÃO',
                style: TextStyle(
                  fontSize: 18,
                  color:  Color(0xFF333333),
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
              
                child: Text(
                  '${controller.score} pts',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              // Tabuleiro Responsivo
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: AspectRatio(
                      aspectRatio:
                          6 /
                          10, // Proporção exata do grid (6 colunas x 10 linhas)
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: GameGrid(
                          currentPiece: controller.currentPiece,
                          board: controller.board,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Botão Encerrar
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: BtnShape(
                  text: 'ENCERRAR',
                  onPressed: () => finishGame(controller.score),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
