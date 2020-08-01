import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetoris/model/base_tetrimino.dart';
import 'package:flutter_tetoris/util/tetrimino.dart';

class DisplayTetrimino extends StatefulWidget {
  final int initHorizontalPosition;
  final TETRIMINO_NAME initTetrimino;
  final int initVerticalPosition;
  final int rotatePosition;
  final Function(TETRIMINO_NAME, bool) existDisablePosition;
  final Function(int) changeRightHorizontalPosition;
  final Function(int) changeBottomVerticalPosition;

  DisplayTetrimino({
    @required this.initTetrimino,
    @required this.initHorizontalPosition,
    @required this.initVerticalPosition,
    @required this.rotatePosition,
    @required this.existDisablePosition,
    @required this.changeRightHorizontalPosition,
    @required this.changeBottomVerticalPosition,
  });

  @override
  _DisplayTetriminoState createState() => _DisplayTetriminoState();
}

class _DisplayTetriminoState extends State<DisplayTetrimino> {
  Container _getTetriminoWidget(TETRIMINO_NAME name, bool collision) {
    if (collision) {
      return Container(
        width: 30,
        height: 30,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: getTetriminoColor(name),
          border: Border.all(color: Colors.black),
        ),
      );
    } else {
      return Container(
        width: 30,
        height: 30,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.transparent),
        ),
      );
    }
  }

  List<Row> createItem(TETRIMINO_NAME name) {
    List<Row> _tetriminoList = [];
    TetriminoInfo itemInfo;
    switch (name) {
      case TETRIMINO_NAME.I:
        itemInfo = tetriminoI(widget.rotatePosition);
        break;
      case TETRIMINO_NAME.T:
        itemInfo = tetriminoT(widget.rotatePosition);
        break;
      case TETRIMINO_NAME.S:
        itemInfo = tetriminoS(widget.rotatePosition);
        break;
      case TETRIMINO_NAME.Z:
        itemInfo = tetriminoZ(widget.rotatePosition);
        break;
      case TETRIMINO_NAME.J:
        itemInfo = tetriminoJ(widget.rotatePosition);
        break;
      case TETRIMINO_NAME.L:
        itemInfo = tetriminoL(widget.rotatePosition);
        break;
      case TETRIMINO_NAME.O:
        itemInfo = tetriminoO(widget.rotatePosition);
        break;
    }

    widget.existDisablePosition(name, itemInfo.disableCollision);
    itemInfo
        .tetrimino
        .forEach((TetriminoCollision element) {
      List<Widget> _listVertical = [];
      int cnt = 0;
      element.collision.forEach((bool value) {
        if (!itemInfo.disableCollision ||
            widget.initHorizontalPosition >= 0) {
          _listVertical.add(
            _getTetriminoWidget(name, value),
          );
        } else if (itemInfo.disableCollision && cnt > 0) {
          _listVertical.add(
            _getTetriminoWidget(name, value),
          );
        }
        cnt++;
      });
      widget.changeRightHorizontalPosition(element.collision.length);
      _tetriminoList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _listVertical,
        ),
      );
    });
    widget.changeBottomVerticalPosition(itemInfo.tetrimino.length);

    return _tetriminoList;
  }

  List<Widget> _createCell(int width, int height) {
    return [
      Container(
        width: width * 30.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.transparent),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: height * 30.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.transparent),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: createItem(widget.initTetrimino),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 70.0),
      child: Row(
        children: _createCell(
            widget.initHorizontalPosition >= 0
                ? widget.initHorizontalPosition
                : 0,
            widget.initVerticalPosition),
      ),
    );
  }
}
