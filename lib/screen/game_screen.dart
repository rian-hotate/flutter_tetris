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

  TETRIMINO_NAME initTetrimino;

  @override
  void initState() {
    super.initState();
    // TODO 動的にテトリミノを変える
    initTetrimino = TETRIMINO_NAME.T;
    baseHorizontalPosition = 4;
    rightHorizontalPosition = 3;
    baseVerticalPosition = 0;
    bottomVerticalPosition = 2;
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
                            if (baseHorizontalPosition > 0)
                              baseHorizontalPosition--;
                          });
                        },
                        iconSize: 55.0,
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}
