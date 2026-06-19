import 'dart:async';
import 'dart:math';
import '../models/piece_model.dart';

class GameController {
  // GERAR PEÇA ALEATÓRIA
  final Random _random = Random();

  // lista com as formas de peças
  final List<Piece Function()> pieces = [
    PiecesShape.lShape,
    PiecesShape.line,
    PiecesShape.tShape,
    PiecesShape.zShape,
  ];

  // função que vai retornar a peça aleatória
  Piece getRandomPiece() {
    return pieces[_random.nextInt(pieces.length)]();
  }

  // peça atual
  late Piece currentPiece;

  // armazenamento dos pontos
  int score = 0;
  
  // PROPRIEDADES DA CLASS 
  bool isStarting = true;
  bool isGameOver = false; 
  int startCount = 3;

  // matriz que representa o tabuleiro
  List<List<int>> board = List.generate(10, (_) => List.generate(6, (_) => 0));

  Timer? timer;

  // Atualiza a interface sempre que o estado do jogo muda.
  final void Function() onUpdate;

  // Notifica quando ocorre Game Over.
  final void Function(int score) onGameOver;

  GameController({required this.onUpdate, required this.onGameOver});

  // Contagem regressiva
  void startGameCountdown() {
    startCount = 3;
    isStarting = true;
    isGameOver = false; 

    currentPiece = getRandomPiece();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      startCount--;

      if (startCount <= 0) {
        timer.cancel();
        isStarting = false; // Aqui libera o jogo de fato
        start();
      }
      onUpdate();
    });
  }

  // Interrompe o loop do jogo.
  void stop() {
    isGameOver = true; // Trava os movimentos quando parar manualmente ou perder
    timer?.cancel();
  }

  // Loop principal
  void start() {
    timer?.cancel();

    timer = Timer.periodic(Duration(milliseconds:500), (_) {
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


  // Fixa a peça atual no tabuleiro e gera uma nova peça.
  void lockPiece() {
    for (int r = 0; r < currentPiece.shape.length; r++) {
      for (int c = 0; c < currentPiece.shape[r].length; c++) {
        if (currentPiece.shape[r][c] == 1) {
          board[currentPiece.row + r][currentPiece.col + c] = 1;
        }
      }
    }

    // pontuação por peça
    score++;

    currentPiece = getRandomPiece();
  }

  // Verifica se a peça pode continuar descendo
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

  // Verifica se a peça pode ir para o lado
  bool canMoveSide(int direction) {
    for (int r = 0; r < currentPiece.shape.length; r++) {
      for (int c = 0; c < currentPiece.shape[r].length; c++) {
        if (currentPiece.shape[r][c] == 1) {
          int nextRow = currentPiece.row + r;
          int nextCol = currentPiece.col + c + direction;
          if (nextCol < 0 || nextCol >= 6) {
            return false;
          }
          if (board[nextRow][nextCol] == 1) return false;
        }
      }
    }
    return true;
  }

  // Verifica se a posição inicial da nova peça está bloqueada.
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

  // Funções de movimentação 
  void movLeft() {
    if (isStarting || isGameOver) return; 

    if (canMoveSide(-1)) {
      currentPiece.col--;
      onUpdate();
    }
  }

  void movRight() {
    if (isStarting || isGameOver) return; 

    if (canMoveSide(1)) {
      currentPiece.col++;
      onUpdate();
    }
  }
}