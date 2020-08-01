import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetoris/model/base_tetrimino.dart';
import 'package:flutter_tetoris/util/tetrimino.dart';

class DisplayNextTetrimino extends StatefulWidget {
  final TETRIMINO_NAME initTetrimino;
  final int rotatePosition;

  DisplayNextTetrimino({
    @required this.initTetrimino,
    @required this.rotatePosition,
  });

  @override
  _DisplayNextTetriminoState createState() => _DisplayNextTetriminoState();
}

class _DisplayNextTetriminoState extends State<DisplayNextTetrimino> {
  Container _getTetriminoWidget(TETRIMINO_NAME name, bool collision) {
    if (collision) {
      return Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: getTetriminoColor(name),
          border: Border.all(color: Colors.black),
        ),
      );
    } else {
      return Container(
        width: 15,
        height: 15,
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

    itemInfo.tetrimino.forEach((TetriminoCollision element) {
      List<Widget> _listVertical = [];
      element.collision.forEach((bool value) {
        _listVertical.add(
          _getTetriminoWidget(name, value),
        );
      });
      _tetriminoList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _listVertical,
        ),
      );
    });

    return _tetriminoList;
  }

  List<Widget> _createCell() {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: createItem(widget.initTetrimino),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _createCell(),
          ),
        ],
      ),
    );
  }
}
