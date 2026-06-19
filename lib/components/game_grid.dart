import 'package:flutter/material.dart';

import 'package:my_tetris_1/models/piece_model.dart';

class GameGrid extends StatelessWidget {
  final Piece currentPiece;
  final List<List<int>> board;

  const GameGrid({
    super.key,
    required this.currentPiece,
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 10,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 60,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
          ),
          itemBuilder: (context, index) {
            final row = index ~/ 6;
            final col = index % 6;

            // bloco fixo do board
            final isFixed = board[row][col] == 1;

            // bloco da peça atual
            bool isPiece = false;

            for (int r = 0; r < currentPiece.shape.length; r++) {
              for (int c = 0; c < currentPiece.shape[r].length; c++) {
                if (currentPiece.shape[r][c] == 1) {
                  if (row == currentPiece.row + r &&
                      col == currentPiece.col + c) {
                    isPiece = true;
                  }
                }
              }
            }

            return Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: isPiece || isFixed
                    ? Colors.blue
                    : Color(0xFFEDEDED),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(4))
              ),
            );
          },
        ),
      ),
    );
  }
}