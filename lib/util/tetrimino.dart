import 'package:flutter/material.dart';
import 'package:flutter_tetoris/model/base_tetrimino.dart';

enum TETRIMINO_NAME { I, T, S, Z, J, L, O }

TetriminoInfo tetriminoI(int rotatePosition) {
  return BaseTetrimino().listTetriminoI(rotatePosition);
}

TetriminoInfo tetriminoT(int rotatePosition) {
  return BaseTetrimino().listTetriminoT(rotatePosition);
}

TetriminoInfo tetriminoS(int rotatePosition) {
  return BaseTetrimino().listTetriminoS(rotatePosition);
}

TetriminoInfo tetriminoZ(int rotatePosition) {
  return BaseTetrimino().listTetriminoZ(rotatePosition);
}

TetriminoInfo tetriminoJ(int rotatePosition) {
  return BaseTetrimino().listTetriminoJ(rotatePosition);
}

TetriminoInfo tetriminoL(int rotatePosition) {
  return BaseTetrimino().listTetriminoL(rotatePosition);
}

TetriminoInfo tetriminoO(int rotatePosition) {
  return BaseTetrimino().listTetriminoO(rotatePosition);
}

Color getTetriminoColor(TETRIMINO_NAME name) {
  switch (name) {
    case TETRIMINO_NAME.I:
      return Colors.blueAccent;
      break;
    case TETRIMINO_NAME.T:
      return Colors.purpleAccent;
      break;
    case TETRIMINO_NAME.S:
      return Colors.red;
      break;
    case TETRIMINO_NAME.Z:
      return Colors.green;
      break;
    case TETRIMINO_NAME.J:
      return Colors.blue;
      break;
    case TETRIMINO_NAME.L:
      return Colors.orange;
      break;
    case TETRIMINO_NAME.O:
      return Colors.yellow;
      break;
  }
  return Colors.transparent;
}
