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
