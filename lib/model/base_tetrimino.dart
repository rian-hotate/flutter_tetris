import 'dart:core';

import 'package:flutter_tetoris/util/tetrimino.dart';

class BaseTetrimino {

  List<TetriminoCollision> get listTetriminoI => createTetrimino(TETRIMINO_NAME.I);
  List<TetriminoCollision> get listTetriminoT => createTetrimino(TETRIMINO_NAME.T);
  List<TetriminoCollision> get listTetriminoS => createTetrimino(TETRIMINO_NAME.S);
  List<TetriminoCollision> get listTetriminoZ => createTetrimino(TETRIMINO_NAME.Z);
  List<TetriminoCollision> get listTetriminoJ => createTetrimino(TETRIMINO_NAME.J);
  List<TetriminoCollision> get listTetriminoL => createTetrimino(TETRIMINO_NAME.L);
  List<TetriminoCollision> get listTetriminoO => createTetrimino(TETRIMINO_NAME.O);

  List<TetriminoCollision> createTetrimino(TETRIMINO_NAME name) {
    List<TetriminoCollision> itemList = [];
    for (int i = 0; i < 4; i++) {
      itemList.add(
        TetriminoCollision().createCollision(name, i),
      );
    }
    return itemList;
  }
}

class TetriminoCollision {
  List<bool> collision;

  TetriminoCollision createCollision(TETRIMINO_NAME name, int index) {
    switch(name) {
      case TETRIMINO_NAME.I:
        return _setCollisionI(index);
        break;
      case TETRIMINO_NAME.T:
        return _setCollisionT(index);
        break;
      case TETRIMINO_NAME.S:
        return _setCollisionS(index);
        break;
      case TETRIMINO_NAME.Z:
        return _setCollisionZ(index);
        break;
      case TETRIMINO_NAME.J:
        return _setCollisionJ(index);
        break;
      case TETRIMINO_NAME.L:
        return _setCollisionL(index);
        break;
      case TETRIMINO_NAME.O:
        return _setCollisionO(index);
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionI(int index) {
    collision = [];
    switch(index) {
      case 0:
        collision.insertAll(0, [true, true, true, true]);
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        print("Error: No Such Index");
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionT(int index) {
    collision = [];
    switch(index) {
      case 0:
        collision.insertAll(0, [false, true]);
        break;
      case 1:
        collision.insertAll(0, [true, true]);
        break;
      case 2:
        collision.insertAll(0, [false, true]);
        break;
      case 3:
        break;
      default:
        print("Error: No Such Index");
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionS(int index) {
    collision = [];
    switch(index) {
      case 0:
        collision.insertAll(0, [true, false,]);
        break;
      case 1:
        collision.insertAll(0, [true, true,]);
        break;
      case 2:
        collision.insertAll(0, [false, true,]);
        break;
      case 3:
        break;
      default:
        print("Error: No Such Index");
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionZ(int index) {
    collision = [];
    switch(index) {
      case 0:
        collision.insertAll(0, [false, true,]);
        break;
      case 1:
        collision.insertAll(0, [true, true,]);
        break;
      case 2:
        collision.insertAll(0, [true, false,]);
        break;
      case 3:
        break;
      default:
        print("Error: No Such Index");
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionJ(int index) {
    collision = [];
    switch(index) {
      case 0:
        collision.insertAll(0, [false, false, true]);
        break;
      case 1:
        collision.insertAll(0, [true, true, true]);
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        print("Error: No Such Index");
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionL(int index) {
    collision = [];
    switch(index) {
      case 0:
        collision.insertAll(0, [true, true, true]);
        break;
      case 1:
        collision.insertAll(0, [false, false, true]);
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        print("Error: No Such Index");
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionO(int index) {
    collision = [];
    switch(index) {
      case 0:
        collision.insertAll(0, [true, true]);
        break;
      case 1:
        collision.insertAll(0, [true, true]);
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        print("Error: No Such Index");
        break;
    }
    return this;
  }
}
