import 'dart:async';
import 'dart:math';
import '../models/pieceModel.dart';

class GameController {
  //GERAR PEÇA ALEATÓTIA
  final Random _random = Random();

  final List<Piece Function()> pieces = [
    PiecesShape.lShape,
    PiecesShape.line,
    PiecesShape.tShape,
    PiecesShape.zShape,
  ];

  Piece getRandomPiece() {
    return pieces[_random.nextInt(pieces.length)]();
  }

  late Piece currentPiece;
  //armazenamento dos pontos
  int score = 0;
  bool isStarting = true;
  int startCount = 3;

  //matriz
  List<List<int>> board = List.generate(10, (_) => List.generate(6, (_) => 0));

  //CONTROLE DE TEMPO
  Timer? timer;

  final void Function() onUpdate;
  final void Function(int score) onGameOver;

  GameController({required this.onUpdate, required this.onGameOver});

  //Contagem regressiva
  void startGameCountdown() {
    startCount = 3;
    isStarting = true;
    currentPiece = getRandomPiece();

    //contagem inicial antes do inicio do jogo
    Timer.periodic(const Duration(seconds: 1), (timer) {
      startCount--;

      //quando contagem for 0 começa o jogo
      if (startCount <= 0) {
        timer.cancel();
        isStarting = false;
        start(); //
      }

      onUpdate();
    });
  }

  //Começar jogo
  void start() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (canMoveDown()) {
        currentPiece.row++;
      } else {
        lockPiece();

        if (_isSpawnBlocked()) {
          stop();
          onGameOver(score);
          return;
        }
      }

      onUpdate();
    });
  }

  void stop() {
    timer?.cancel();
  }

  void lockPiece() {
    for (int r = 0; r < currentPiece.shape.length; r++) {
      for (int c = 0; c < currentPiece.shape[r].length; c++) {
        if (currentPiece.shape[r][c] == 1) {
          board[currentPiece.row + r][currentPiece.col + c] = 1;
        }
      }
    }

    //score por peça
    score++;

    currentPiece = getRandomPiece(); 
  }
  
  bool canMoveDown() {
    for (int r = 0; r < currentPiece.shape.length; r++) {
      for (int c = 0; c < currentPiece.shape[r].length; c++) {
        if (currentPiece.shape[r][c] == 1) {
          int nextRow = currentPiece.row + r + 1;
          int nextCol = currentPiece.col + c;

          if (nextRow >= 10) return false;
          if (nextCol < 0 || nextCol >= 6) return false;

          if (board[nextRow][nextCol] == 1) return false;
        }
      }
    }
    return true;
  }

  bool _isSpawnBlocked() {
    for (int r = 0; r < currentPiece.shape.length; r++) {
      for (int c = 0; c < currentPiece.shape[r].length; c++) {
        if (currentPiece.shape[r][c] == 1) {
          if (board[currentPiece.row + r][currentPiece.col + c] == 1) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
