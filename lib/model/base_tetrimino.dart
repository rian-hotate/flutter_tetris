import 'dart:core';

import 'package:flutter_tetoris/util/tetrimino.dart';

class TetriminoInfo {
  List<TetriminoCollision> tetrimino;
  bool disableCollision;

  TetriminoInfo({this.tetrimino, this.disableCollision});
}

class BaseTetrimino {
  TetriminoInfo listTetriminoI(int rotatePosition) =>
      createTetrimino(TETRIMINO_NAME.I, rotatePosition);

  TetriminoInfo listTetriminoT(int rotatePosition) =>
      createTetrimino(TETRIMINO_NAME.T, rotatePosition);

  TetriminoInfo listTetriminoS(int rotatePosition) =>
      createTetrimino(TETRIMINO_NAME.S, rotatePosition);

  TetriminoInfo listTetriminoZ(int rotatePosition) =>
      createTetrimino(TETRIMINO_NAME.Z, rotatePosition);

  TetriminoInfo listTetriminoJ(int rotatePosition) =>
      createTetrimino(TETRIMINO_NAME.J, rotatePosition);

  TetriminoInfo listTetriminoL(int rotatePosition) =>
      createTetrimino(TETRIMINO_NAME.L, rotatePosition);

  TetriminoInfo listTetriminoO(int rotatePosition) =>
      createTetrimino(TETRIMINO_NAME.O, rotatePosition);

  TetriminoInfo createTetrimino(TETRIMINO_NAME name, int rotatePosition) {
    TetriminoInfo itemList = TetriminoInfo(tetrimino: []);
    for (int i = 0; i < 4; i++) {
      if (TetriminoCollision()
              .createCollision(name, i, rotatePosition)
              .collision
              .length >
          0)
        itemList.tetrimino.add(
          TetriminoCollision().createCollision(name, i, rotatePosition),
        );
    }
    itemList.disableCollision =
        TetriminoCollision()._getDisableCollision(name, rotatePosition);
    return itemList;
  }
}

class TetriminoCollision {
  List<bool> collision;

  TetriminoCollision createCollision(
      TETRIMINO_NAME name, int index, int rotatePosition) {
    switch (name) {
      case TETRIMINO_NAME.I:
        return _setCollisionI(index, rotatePosition);
        break;
      case TETRIMINO_NAME.T:
        return _setCollisionT(index, rotatePosition);
        break;
      case TETRIMINO_NAME.S:
        return _setCollisionS(index, rotatePosition);
        break;
      case TETRIMINO_NAME.Z:
        return _setCollisionZ(index, rotatePosition);
        break;
      case TETRIMINO_NAME.J:
        return _setCollisionJ(index, rotatePosition);
        break;
      case TETRIMINO_NAME.L:
        return _setCollisionL(index, rotatePosition);
        break;
      case TETRIMINO_NAME.O:
        return _setCollisionO(index, rotatePosition);
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionI(int index, int rotatePosition) {
    collision = [];
    switch (rotatePosition) {
      case 0:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, false, false, false]);
            break;
          case 1:
            collision.insertAll(0, [true, true, true, true]);
            break;
          case 2:
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 1:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, true, false, false]);
            break;
          case 1:
            collision.insertAll(0, [false, true, false, false]);
            break;
          case 2:
            collision.insertAll(0, [false, true, false, false]);
            break;
          case 3:
            collision.insertAll(0, [false, true, false, false]);
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 2:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, false, false, false]);
            break;
          case 1:
            collision.insertAll(0, [true, true, true, true]);
            break;
          case 2:
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 3:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, true, false, false]);
            break;
          case 1:
            collision.insertAll(0, [false, true, false, false]);
            break;
          case 2:
            collision.insertAll(0, [false, true, false, false]);
            break;
          case 3:
            collision.insertAll(0, [false, true, false, false]);
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
    }

    return this;
  }

  TetriminoCollision _setCollisionT(int index, int rotatePosition) {
    collision = [];
    switch (rotatePosition) {
      case 0:
        switch (index) {
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
        break;
      case 1:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, true, false]);
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
        break;
      case 2:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, true, false]);
            break;
          case 1:
            collision.insertAll(0, [false, true, true]);
            break;
          case 2:
            collision.insertAll(0, [false, true, false]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 3:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, false, false]);
            break;
          case 1:
            collision.insertAll(0, [true, true, true]);
            break;
          case 2:
            collision.insertAll(0, [false, true, false]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      default:
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionS(int index, int rotatePosition) {
    collision = [];
    switch (rotatePosition) {
      case 0:
        switch (index) {
          case 0:
            collision.insertAll(0, [
              true,
              false,
            ]);
            break;
          case 1:
            collision.insertAll(0, [
              true,
              true,
            ]);
            break;
          case 2:
            collision.insertAll(0, [
              false,
              true,
            ]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 1:
        switch (index) {
          case 0:
            collision.insertAll(0, [
              false,
              false,
              false,
            ]);
            break;
          case 1:
            collision.insertAll(0, [
              false,
              true,
              true,
            ]);
            break;
          case 2:
            collision.insertAll(0, [
              true,
              true,
              false,
            ]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 2:
        switch (index) {
          case 0:
            collision.insertAll(0, [
              true,
              false,
            ]);
            break;
          case 1:
            collision.insertAll(0, [
              true,
              true,
            ]);
            break;
          case 2:
            collision.insertAll(0, [
              false,
              true,
            ]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 3:
        switch (index) {
          case 0:
            collision.insertAll(0, [
              false,
              false,
              false,
            ]);
            break;
          case 1:
            collision.insertAll(0, [
              false,
              true,
              true,
            ]);
            break;
          case 2:
            collision.insertAll(0, [
              true,
              true,
              false,
            ]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionZ(int index, int rotatePosition) {
    collision = [];
    switch (rotatePosition) {
      case 0:
        switch (index) {
          case 0:
            collision.insertAll(0, [
              false,
              true,
            ]);
            break;
          case 1:
            collision.insertAll(0, [
              true,
              true,
            ]);
            break;
          case 2:
            collision.insertAll(0, [
              true,
              false,
            ]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 1:
        switch (index) {
          case 0:
            collision.insertAll(0, [
              false,
              false,
              false,
            ]);
            break;
          case 1:
            collision.insertAll(0, [
              true,
              true,
              false,
            ]);
            break;
          case 2:
            collision.insertAll(0, [
              false,
              true,
              true,
            ]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 2:
        switch (index) {
          case 0:
            collision.insertAll(0, [
              false,
              true,
            ]);
            break;
          case 1:
            collision.insertAll(0, [
              true,
              true,
            ]);
            break;
          case 2:
            collision.insertAll(0, [
              true,
              false,
            ]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 3:
        switch (index) {
          case 0:
            collision.insertAll(0, [
              false,
              false,
              false,
            ]);
            break;
          case 1:
            collision.insertAll(0, [
              true,
              true,
              false,
            ]);
            break;
          case 2:
            collision.insertAll(0, [
              false,
              true,
              true,
            ]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionJ(int index, int rotatePosition) {
    collision = [];
    switch (rotatePosition) {
      case 0:
        switch (index) {
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
        break;
      case 1:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, true, false]);
            break;
          case 1:
            collision.insertAll(0, [false, true, false]);
            break;
          case 2:
            collision.insertAll(0, [false, true, true]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 2:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, false, false]);
            break;
          case 1:
            collision.insertAll(0, [true, true, true]);
            break;
          case 2:
            collision.insertAll(0, [true, false, false]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 3:
        switch (index) {
          case 0:
            collision.insertAll(0, [true, true]);
            break;
          case 1:
            collision.insertAll(0, [false, true,]);
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
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionL(int index, int rotatePosition) {
    collision = [];
    switch (rotatePosition) {
      case 0:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, false, false]);
            break;
          case 1:
            collision.insertAll(0, [true, true, true]);
            break;
          case 2:
            collision.insertAll(0, [false, false, true]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 1:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, true]);
            break;
          case 1:
            collision.insertAll(0, [false, true]);
            break;
          case 2:
            collision.insertAll(0, [true, true]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
      case 2:
        switch (index) {
          case 0:
            collision.insertAll(0, [true, false, false]);
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
        break;
      case 3:
        switch (index) {
          case 0:
            collision.insertAll(0, [false, true, true]);
            break;
          case 1:
            collision.insertAll(0, [false, true, false]);
            break;
          case 2:
            collision.insertAll(0, [false, true, false]);
            break;
          case 3:
            break;
          default:
            print("Error: No Such Index");
            break;
        }
        break;
    }
    return this;
  }

  TetriminoCollision _setCollisionO(int index, int rotatePosition) {
    collision = [];
    switch (index) {
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

  bool _getDisableCollision(TETRIMINO_NAME name, int rotatePosition) {
    switch (name) {
      case TETRIMINO_NAME.I:
        return (rotatePosition == 0 || rotatePosition == 2);
        break;
      case TETRIMINO_NAME.T:
        return rotatePosition == 3;
        break;
      case TETRIMINO_NAME.S:
      case TETRIMINO_NAME.Z:
        return rotatePosition == 1;
        break;
      case TETRIMINO_NAME.J:
        return rotatePosition == 2;
        break;
      case TETRIMINO_NAME.L:
        return rotatePosition == 0;
        break;
      case TETRIMINO_NAME.O:
        // TODO: Handle this case.
        break;
    }
    return false;
  }
}
