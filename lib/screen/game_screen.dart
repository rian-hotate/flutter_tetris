import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetoris/model/base_tetrimino.dart';
import 'package:flutter_tetoris/model/piled_tetrimino.dart';
import 'package:flutter_tetoris/screen/display_piled_up_tetrimino.dart';
import 'package:flutter_tetoris/screen/display_tetrimino.dart';
import 'package:flutter_tetoris/util/tetrimino.dart';

import 'display_next_tetrimino.dart';

class GameScreen extends StatefulWidget {
  final VoidCallback resetCallBack;

  GameScreen({@required this.resetCallBack});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int baseHorizontalPosition;
  int rightHorizontalPosition;
  int baseVerticalPosition;
  int bottomVerticalPosition;
  int rotatePosition;
  int nextRotatePosition;
  int minHorizontal;
  Timer _timer;
  int score;
  List<List<PiledTetrimino>> piledUpTetrimino;
  TETRIMINO_NAME initTetrimino;
  TETRIMINO_NAME nextTetrimino;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  void existDisableCollision(TETRIMINO_NAME name, bool exist) {
    switch (name) {
      case TETRIMINO_NAME.I:
      case TETRIMINO_NAME.T:
      case TETRIMINO_NAME.S:
      case TETRIMINO_NAME.Z:
      case TETRIMINO_NAME.J:
      case TETRIMINO_NAME.L:
        if (exist)
          minHorizontal = -1;
        else
          minHorizontal = 0;
        break;
      case TETRIMINO_NAME.O:
        break;
    }
  }

  void changeRightHorizontalPosition(int position) {
    rightHorizontalPosition = position;
  }

  void changeBottomVerticalPosition(int position) {
    bottomVerticalPosition = position;
  }

  void initGame() {
    if (_timer != null) _timer.cancel();
    score = 0;
    piledUpTetrimino = [];
    for (int i = 0; i < 20; i++) {
      List<PiledTetrimino> _row = [];
      for (int j = 0; j < 10; j++) {
        _row.add(
          PiledTetrimino(collision: false),
        );
      }
      piledUpTetrimino.add(_row);
    }
    _showRandomTetrimino();
    setTimer();
  }

  void _showRandomTetrimino() {
    Random randomTetrimino = Random();
    Random randomRotate = Random();

    if (nextTetrimino != null) {
      initTetrimino = nextTetrimino;
      nextTetrimino = TETRIMINO_NAME
          .values[randomTetrimino.nextInt(TETRIMINO_NAME.values.length)];
    } else {
      initTetrimino = TETRIMINO_NAME
          .values[randomTetrimino.nextInt(TETRIMINO_NAME.values.length)];
      nextTetrimino = TETRIMINO_NAME
          .values[randomTetrimino.nextInt(TETRIMINO_NAME.values.length)];
    }
    baseHorizontalPosition = 4;
    baseVerticalPosition = 0;
    if (nextRotatePosition != null) {
      rotatePosition = nextRotatePosition;
      nextRotatePosition = randomRotate.nextInt(4);
    } else {
      rotatePosition = randomRotate.nextInt(4);
      nextRotatePosition = randomRotate.nextInt(4);
    }
    minHorizontal = 0;

    _checkGameOver(initTetrimino);
  }

  List<Widget> _createCell() {
    List<Widget> list = [];
    for (int i = 0; i < 10; i++) {
      List<Widget> verticalList = [];
      for (int j = 0; j < 20; j++) {
        verticalList.add(
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.grey),
            ),
          ),
        );
      }
      list.add(
        Column(
          children: verticalList,
        ),
      );
    }
    return list;
  }

  void _downOperation(TETRIMINO_NAME name, bool isTap) {
    if (_timer != null) _timer.cancel();
    TetriminoInfo itemInfo;
    switch (name) {
      case TETRIMINO_NAME.I:
        itemInfo = tetriminoI(rotatePosition);
        break;
      case TETRIMINO_NAME.T:
        itemInfo = tetriminoT(rotatePosition);
        break;
      case TETRIMINO_NAME.S:
        itemInfo = tetriminoS(rotatePosition);
        break;
      case TETRIMINO_NAME.Z:
        itemInfo = tetriminoZ(rotatePosition);
        break;
      case TETRIMINO_NAME.J:
        itemInfo = tetriminoJ(rotatePosition);
        break;
      case TETRIMINO_NAME.L:
        itemInfo = tetriminoL(rotatePosition);
        break;
      case TETRIMINO_NAME.O:
        itemInfo = tetriminoO(rotatePosition);
        break;
    }

    bool collisionFlag = false;

    for (int i = itemInfo.tetrimino.length - 1; i >= 0; i--) {
      int cnt = 0;
      itemInfo.tetrimino[i].collision.forEach((element) {
        if (element) {
          if (piledUpTetrimino.length - 1 >= baseVerticalPosition + i + 1 &&
              piledUpTetrimino[baseVerticalPosition + i + 1]
                      [baseHorizontalPosition + cnt]
                  .collision) {
            collisionFlag = true;
            return;
          } else if (baseVerticalPosition + i + 1 == 20) {
            collisionFlag = true;
            return;
          }
        }
        cnt++;
      });
    }

    if (collisionFlag) {
      for (int i = 0; i < itemInfo.tetrimino.length; i++) {
        for (int j = 0; j < itemInfo.tetrimino[i].collision.length; j++) {
          if (itemInfo.tetrimino[i].collision[j]) {
            List<PiledTetrimino> item =
                piledUpTetrimino[baseVerticalPosition + i];
            item.replaceRange(
                baseHorizontalPosition + j,
                baseHorizontalPosition + j + 1,
                [PiledTetrimino(collision: true, tetrimino: name)]);
            piledUpTetrimino.replaceRange(
                baseVerticalPosition + i, baseVerticalPosition + i + 1, [item]);
          }
        }
      }

      int _index = 0;
      List<int> _eraseIndex = [];

      piledUpTetrimino.forEach((column) {
        bool _eraseFlag = true;
        column.forEach((row) {
          if (!row.collision) _eraseFlag = false;
        });

        if (_eraseFlag) _eraseIndex.add(_index);
        _index++;
      });

      _eraseIndex.reversed.forEach((element) {
        piledUpTetrimino.removeAt(element);
      });

      _eraseIndex.forEach((element) {
        List<PiledTetrimino> _row = [];
        for (int j = 0; j < 10; j++) {
          _row.add(
            PiledTetrimino(collision: false),
          );
        }
        score++;
        piledUpTetrimino.insert(0, _row);
      });

      _showRandomTetrimino();
    } else if (isTap) {
      baseVerticalPosition++;
      _downOperation(name, isTap);
    } else {
      baseVerticalPosition++;
    }

    setTimer();
  }

  void _horizontalOperation(TETRIMINO_NAME name, bool leftOperation) {
    if (_timer != null) _timer.cancel();

    TetriminoInfo itemInfo;
    switch (name) {
      case TETRIMINO_NAME.I:
        itemInfo = tetriminoI(rotatePosition);
        break;
      case TETRIMINO_NAME.T:
        itemInfo = tetriminoT(rotatePosition);
        break;
      case TETRIMINO_NAME.S:
        itemInfo = tetriminoS(rotatePosition);
        break;
      case TETRIMINO_NAME.Z:
        itemInfo = tetriminoZ(rotatePosition);
        break;
      case TETRIMINO_NAME.J:
        itemInfo = tetriminoJ(rotatePosition);
        break;
      case TETRIMINO_NAME.L:
        itemInfo = tetriminoL(rotatePosition);
        break;
      case TETRIMINO_NAME.O:
        itemInfo = tetriminoO(rotatePosition);
        break;
    }

    bool collisionFlag = false;

    for (int i = itemInfo.tetrimino.length - 1; i >= 0; i--) {
      int cnt = 0;
      itemInfo.tetrimino[i].collision.forEach((element) {
        if (element) {
          if (leftOperation) {
            if (baseHorizontalPosition == minHorizontal ||
                baseHorizontalPosition + cnt - 1 < minHorizontal ||
                piledUpTetrimino[baseVerticalPosition + i]
                        [baseHorizontalPosition + cnt - 1]
                    .collision) {
              collisionFlag = true;
              return;
            }
          } else {
            if (baseHorizontalPosition + rightHorizontalPosition >= 10 ||
                baseHorizontalPosition + cnt + 1 >= 10 ||
                piledUpTetrimino[baseVerticalPosition + i]
                        [baseHorizontalPosition + cnt + 1]
                    .collision) {
              collisionFlag = true;
              return;
            }
          }
        }
        cnt++;
      });
    }

    if (!collisionFlag) {
      if (leftOperation)
        baseHorizontalPosition--;
      else
        baseHorizontalPosition++;
    }

    setTimer();
  }

  void _changeRotate(TETRIMINO_NAME name, bool leftDirection) {
    bool canOperation = false;
    switch (name) {
      case TETRIMINO_NAME.I:
        if ((rotatePosition != 1 && rotatePosition != 3) ||
            baseVerticalPosition + bottomVerticalPosition <= 18) {
          if (leftDirection) {
            if (rightHorizontalPosition == 4 ||
                (baseHorizontalPosition >= 0 &&
                    baseHorizontalPosition + rightHorizontalPosition <= 8)) {
              if (!_checkRotateCollision(
                  tetriminoI(rotatePosition), leftDirection))
                canOperation = true;
            }
          } else {
            if (rightHorizontalPosition == 4 ||
                (baseHorizontalPosition >= 0 &&
                    baseHorizontalPosition + rightHorizontalPosition <= 8)) {
              if (!_checkRotateCollision(
                  tetriminoI(rotatePosition), leftDirection))
                canOperation = true;
            }
          }
        }
        break;
      case TETRIMINO_NAME.T:
        if (rotatePosition != 0 ||
            baseVerticalPosition + bottomVerticalPosition < 20) {
          if (leftDirection) {
            if (baseHorizontalPosition != -1 &&
                (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                    rotatePosition != 1)) {
              if (!_checkRotateCollision(
                  tetriminoT(rotatePosition), leftDirection))
                canOperation = true;
            }
          } else {
            if (baseHorizontalPosition != -1 &&
                (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                    rotatePosition != 1)) {
              if (!_checkRotateCollision(
                  tetriminoT(rotatePosition), leftDirection))
                canOperation = true;
            }
          }
        }
        break;
      case TETRIMINO_NAME.S:
        if ((rotatePosition != 0 && rotatePosition != 2) ||
            baseVerticalPosition + bottomVerticalPosition < 20) {
          if (leftDirection) {
            if (baseHorizontalPosition != -1) {
              if (!_checkRotateCollision(
                  tetriminoS(rotatePosition), leftDirection))
                canOperation = true;
            }
          } else {
            if (baseHorizontalPosition != -1) {
              if (!_checkRotateCollision(
                  tetriminoS(rotatePosition), leftDirection))
                canOperation = true;
            }
          }
        }
        break;
      case TETRIMINO_NAME.Z:
        if ((rotatePosition != 0 && rotatePosition != 2) ||
            baseVerticalPosition + bottomVerticalPosition < 20) {
          if (leftDirection) {
            if (baseHorizontalPosition != -1) {
              if (!_checkRotateCollision(
                  tetriminoZ(rotatePosition), leftDirection))
                canOperation = true;
            }
          } else {
            if (baseHorizontalPosition != -1) {
              if (!_checkRotateCollision(
                  tetriminoZ(rotatePosition), leftDirection))
                canOperation = true;
            }
          }
        }
        break;
      case TETRIMINO_NAME.J:
        if (rotatePosition != 0 ||
            baseVerticalPosition + bottomVerticalPosition < 20) {
          if (leftDirection) {
            if (baseHorizontalPosition != -1 &&
                (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                    rotatePosition != 1)) {
              if (!_checkRotateCollision(
                  tetriminoJ(rotatePosition), leftDirection))
                canOperation = true;
            }
          } else {
            if (baseHorizontalPosition != -1 &&
                (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                    rotatePosition != 1)) {
              if (!_checkRotateCollision(
                  tetriminoJ(rotatePosition), leftDirection))
                canOperation = true;
            }
          }
        }
        break;
      case TETRIMINO_NAME.L:
        if (rotatePosition != 0 ||
            baseVerticalPosition + bottomVerticalPosition < 20) {
          if (leftDirection) {
            if (baseHorizontalPosition != -1 &&
                (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                    rotatePosition != 1)) {
              if (!_checkRotateCollision(
                  tetriminoL(rotatePosition), leftDirection))
                canOperation = true;
            }
          } else {
            if (baseHorizontalPosition != -1 &&
                (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                    rotatePosition != 1)) {
              if (!_checkRotateCollision(
                  tetriminoL(rotatePosition), leftDirection))
                canOperation = true;
            }
          }
        }
        break;
      case TETRIMINO_NAME.O:
        // TODO: Handle this case.
        break;
    }

    if (canOperation) {
      if (_timer != null) _timer.cancel();
      if (leftDirection) {
        setState(() {
          if (rotatePosition < 3)
            rotatePosition++;
          else
            rotatePosition = 0;
        });
      } else {
        setState(() {
          if (rotatePosition > 0)
            rotatePosition--;
          else
            rotatePosition = 3;
        });
      }
      setTimer();
    }
  }

  bool _checkRotateCollision(TetriminoInfo tetriminoInfo, bool leftOperation) {
    int _rotate;
    if (leftOperation) {
      if (rotatePosition < 3)
        _rotate = rotatePosition + 1;
      else
        _rotate = 0;
    } else {
      if (rotatePosition > 0)
        _rotate = rotatePosition - 1;
      else
        _rotate = 3;
    }
    bool collisionFlag = false;
    for (int i = tetriminoInfo.tetrimino.length - 1; i >= 0; i--) {
      int cnt = 0;
      tetriminoInfo.tetrimino[i].collision.forEach((element) {
        if (element &&
            piledUpTetrimino[baseVerticalPosition + i]
                    [baseHorizontalPosition + cnt]
                .collision) {
          collisionFlag = true;
          return;
        }
        cnt++;
      });
    }
    return collisionFlag;
  }

  void _checkGameOver(TETRIMINO_NAME name) {
    TetriminoInfo itemInfo;
    switch (name) {
      case TETRIMINO_NAME.I:
        itemInfo = tetriminoI(rotatePosition);
        break;
      case TETRIMINO_NAME.T:
        itemInfo = tetriminoT(rotatePosition);
        break;
      case TETRIMINO_NAME.S:
        itemInfo = tetriminoS(rotatePosition);
        break;
      case TETRIMINO_NAME.Z:
        itemInfo = tetriminoZ(rotatePosition);
        break;
      case TETRIMINO_NAME.J:
        itemInfo = tetriminoJ(rotatePosition);
        break;
      case TETRIMINO_NAME.L:
        itemInfo = tetriminoL(rotatePosition);
        break;
      case TETRIMINO_NAME.O:
        itemInfo = tetriminoO(rotatePosition);
        break;
    }

    bool collisionFlag = false;

    for (int i = itemInfo.tetrimino.length - 1; i >= 0; i--) {
      int cnt = 0;
      itemInfo.tetrimino[i].collision.forEach((element) {
        if (element) {
          if (piledUpTetrimino.length - 1 >= baseVerticalPosition + i &&
              piledUpTetrimino[baseVerticalPosition + i]
                      [baseHorizontalPosition + cnt]
                  .collision) {
            collisionFlag = true;
            return;
          } else if (baseVerticalPosition + i + 1 == 20) {
            collisionFlag = true;
            return;
          }
        }
        cnt++;
      });
    }
    if (collisionFlag) {
      if (_timer != null) _timer.cancel();
      widget.resetCallBack();
    }
  }

  void setTimer() {
    if (_timer == null || !_timer.isActive) {
      int _threshold = (score >= 90 ? 90 : score) * 10;
      _timer =
          Timer.periodic(Duration(milliseconds: 1000 - _threshold), (timer) {
        setState(() {
          _downOperation(initTetrimino, false);
        });
      });
    }
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: _createCell(),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "next",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DisplayNextTetrimino(
                            initTetrimino: nextTetrimino,
                            rotatePosition: nextRotatePosition,
                          ),
                        ),
                        Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Score",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                (score * 100).toString(),
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    // 左移動
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _horizontalOperation(initTetrimino, true);
                          });
                        },
                        iconSize: 55.0,
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    // 左回転
                    Expanded(
                      child: IconButton(
                        onPressed: () => _changeRotate(initTetrimino, true),
                        iconSize: 55.0,
                        icon: Icon(Icons.replay),
                      ),
                    ),
                    // 下移動
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _downOperation(initTetrimino, true);
                          });
                        },
                        iconSize: 55.0,
                        icon: Icon(Icons.arrow_downward),
                      ),
                    ),
                    // 右回転
                    Expanded(
                      child: IconButton(
                        onPressed: () => _changeRotate(initTetrimino, false),
                        iconSize: 55.0,
                        icon: Icon(Icons.refresh),
                      ),
                    ),
                    // 右移動
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _horizontalOperation(initTetrimino, false);
                          });
                        },
                        iconSize: 55.0,
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          DisplayPiledUpTetrimino(piledUpTetrimino: piledUpTetrimino),
          DisplayTetrimino(
            initHorizontalPosition: baseHorizontalPosition,
            initTetrimino: initTetrimino,
            initVerticalPosition: baseVerticalPosition,
            rotatePosition: rotatePosition,
            existDisablePosition: existDisableCollision,
            changeRightHorizontalPosition: changeRightHorizontalPosition,
            changeBottomVerticalPosition: changeBottomVerticalPosition,
          ),
        ],
      ),
    );
  }
}
