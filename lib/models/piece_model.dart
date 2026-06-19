import 'package:flutter/material.dart';

class Piece {
  int id;
  int row;
  int col;
  final Color color;

  //matriz para definir as formas
  List<List<int>> shape;

  Piece({required this.id,required this.row, required this.col, required this.shape, required this.color});
}

class PiecesShape {
  static Piece zShape() {
    return Piece(
      id:  1,
      row: 0,
      col: 2,
      shape: [
        [1, 1, 0],
        [0, 1, 1],
      ], color:Colors.green,
    );
  }

  static Piece line() {
    return Piece(
      id: 2,
      row: 0,
      col: 2,
      shape: [
        [1],
        [1],
        [1],
        [1],
      ], color: Colors.deepOrange,
    );
  }

  static Piece lShape() {
    return Piece(
      id: 3,
      row: 0,
      col: 2,
      shape: [
        [1, 0],
        [1, 0],
        [1, 1],
      ], color: Colors.blue,
    );
  }

  static Piece tShape() {
    return Piece(
      id:4,

      row: 0,
      col: 2,
      shape: [
        [0, 1, 0],
        [1, 1, 1],
      ], color: Colors.pink,
    );
  }
}
