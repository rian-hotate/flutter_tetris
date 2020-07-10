import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetoris/screen/display_tetrimino.dart';
import 'package:flutter_tetoris/util/tetrimino.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int baseHorizontalPosition;
  int rightHorizontalPosition;
  int baseVerticalPosition;
  int bottomVerticalPosition;
  int rotatePosition;
  int minHorizontal;

  TETRIMINO_NAME initTetrimino;

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

  @override
  void initState() {
    super.initState();
    // TODO 動的にテトリミノを変える
    initTetrimino = TETRIMINO_NAME.O;
    baseHorizontalPosition = 4;
    rightHorizontalPosition = 2;
    baseVerticalPosition = 0;
    bottomVerticalPosition = 2;
    rotatePosition = 0;
    minHorizontal = 0;
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

  bool _changeRotate(TETRIMINO_NAME name, bool leftDirection) {
    switch (name) {
      case TETRIMINO_NAME.I:
        print(baseHorizontalPosition);
        if (leftDirection) {
          if (rightHorizontalPosition == 4 ||
              (baseHorizontalPosition >= 0 &&
                  baseHorizontalPosition + rightHorizontalPosition <= 8)) {
            setState(() {
              if (rotatePosition < 3)
                rotatePosition++;
              else
                rotatePosition = 0;
            });
          }
        } else {
          if (rightHorizontalPosition == 4 ||
              (baseHorizontalPosition >= 0 &&
                  baseHorizontalPosition + rightHorizontalPosition <= 8)) {
            setState(() {
              if (rotatePosition < 3)
                rotatePosition++;
              else
                rotatePosition = 0;
            });
          }
        }
        break;
      case TETRIMINO_NAME.T:
        if (leftDirection) {
          if (baseHorizontalPosition != -1 &&
              (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                  rotatePosition != 1)) {
            setState(() {
              if (rotatePosition < 3)
                rotatePosition++;
              else
                rotatePosition = 0;
            });
          }
        } else {
          if (baseHorizontalPosition != -1 &&
              (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                  rotatePosition != 1)) {
            setState(() {
              if (rotatePosition > 0)
                rotatePosition--;
              else
                rotatePosition = 3;
            });
          }
        }
        break;
      case TETRIMINO_NAME.S:
      case TETRIMINO_NAME.Z:
        if (leftDirection) {
          if (baseHorizontalPosition != -1 &&
              baseHorizontalPosition + rightHorizontalPosition < 10) {
            setState(() {
              if (rotatePosition < 3)
                rotatePosition++;
              else
                rotatePosition = 0;
            });
          }
        } else {
          if (baseHorizontalPosition != -1 &&
              baseHorizontalPosition + rightHorizontalPosition < 10) {
            setState(() {
              if (rotatePosition > 0)
                rotatePosition--;
              else
                rotatePosition = 3;
            });
          }
        }
        break;
      case TETRIMINO_NAME.J:
        if (leftDirection) {
          if (baseHorizontalPosition != -1 &&
                  (baseHorizontalPosition + rightHorizontalPosition != 10 ||
              rotatePosition != 0)) {
            setState(() {
              if (rotatePosition < 3)
                rotatePosition++;
              else
                rotatePosition = 0;
            });
          }
        } else {
          if (baseHorizontalPosition != -1 &&
              (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                  rotatePosition != 0)) {
            setState(() {
              if (rotatePosition > 0)
                rotatePosition--;
              else
                rotatePosition = 3;
            });
          }
        }
        break;
      case TETRIMINO_NAME.L:
        if (leftDirection) {
          if (baseHorizontalPosition != -1 &&
              (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                  rotatePosition != 2)) {
            setState(() {
              if (rotatePosition < 3)
                rotatePosition++;
              else
                rotatePosition = 0;
            });
          }
        } else {
          if (baseHorizontalPosition != -1 &&
              (baseHorizontalPosition + rightHorizontalPosition != 10 ||
                  rotatePosition != 2)) {
            setState(() {
              if (rotatePosition > 0)
                rotatePosition--;
              else
                rotatePosition = 3;
            });
          }
        }
        break;
      case TETRIMINO_NAME.O:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: _createCell(),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (baseHorizontalPosition > minHorizontal)
                              baseHorizontalPosition--;
                          });
                        },
                        iconSize: 55.0,
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () => _changeRotate(initTetrimino, true),
                        iconSize: 55.0,
                        icon: Icon(Icons.replay),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (baseVerticalPosition + bottomVerticalPosition <
                                20) baseVerticalPosition++;
                          });
                        },
                        iconSize: 55.0,
                        icon: Icon(Icons.arrow_downward),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () => _changeRotate(initTetrimino, false),
                        iconSize: 55.0,
                        icon: Icon(Icons.refresh),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (baseHorizontalPosition +
                                    rightHorizontalPosition <
                                10) baseHorizontalPosition++;
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
          DisplayTetrimino(
            initHorizontalPosition: baseHorizontalPosition,
            initTetrimino: initTetrimino,
            initVerticalPosition: baseVerticalPosition,
            rotatePosition: rotatePosition,
            existDisablePosition: existDisableCollision,
            changeRightHorizontalPosition: changeRightHorizontalPosition,
          ),
        ],
      ),
    );
  }
}
