import 'dart:ui';

class Piece {
  int row;
  int col;


  //matriz para definir as formas
  List<List<int>> shape;

  Piece({required this.row, required this.col, required this.shape});
}

class PiecesShape {
  static Piece zShape() {
    return Piece(
      row: 0,
      col: 2,
      shape: [
        [1, 1, 0],
        [0, 1, 1],
      ], 
    );
  }

  static Piece line() {
    return Piece(
      row: 0,
      col: 2,
      shape: [
        [1],
        [1],
        [1],
        [1],
      ],
    );
  }

  static Piece lShape() {
    return Piece(
      row: 0,
      col: 2,
      shape: [
        [1, 0],
        [1, 0],
        [1, 1],
      ],
    );
  }

  static Piece tShape() {
    return Piece(
      row: 0,
      col: 2,
      shape: [
        [0, 1, 0],
        [1, 1, 1],
      ],
    );
  }
}
