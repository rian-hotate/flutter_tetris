import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetoris/model/base_tetrimino.dart';
import 'package:flutter_tetoris/util/tetrimino.dart';

class DisplayTetrimino extends StatefulWidget {
  final int initHorizontalPosition;
  final TETRIMINO_NAME initTetrimino;
  final int initVerticalPosition;

  DisplayTetrimino(
      {@required this.initTetrimino,
      @required this.initHorizontalPosition,
      @required this.initVerticalPosition});

  @override
  _DisplayTetriminoState createState() => _DisplayTetriminoState();
}

class _DisplayTetriminoState extends State<DisplayTetrimino> {
  int rightWidth = 0;

  Color _getTetriminoColor(TETRIMINO_NAME name) {
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

  Container _getTetriminoWidget(TETRIMINO_NAME name, bool collision) {
    if (collision) {
      return Container(
        width: 30,
        height: 30,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: _getTetriminoColor(name),
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

  List<Column> createItem(TETRIMINO_NAME name) {
    List<Column> _tetriminoList = [];
    switch (name) {
      case TETRIMINO_NAME.I:
        tetriminoI.forEach((TetriminoCollision element) {
          List<Widget> _listVertical = [];
          int cnt = 0;
          element.collision.forEach((bool value) {
            if (value) rightWidth = cnt;
            _listVertical.add(
              _getTetriminoWidget(name, value),
            );
          });
          cnt++;
          _tetriminoList.add(
            Column(
              children: _listVertical,
            ),
          );
        });
        break;
      case TETRIMINO_NAME.T:
        tetriminoT.forEach((TetriminoCollision element) {
          List<Widget> _listVertical = [];
          int cnt = 0;
          element.collision.forEach((bool value) {
            if (value) rightWidth = cnt;
            _listVertical.add(
              _getTetriminoWidget(name, value),
            );
          });
          cnt++;
          _tetriminoList.add(
            Column(
              children: _listVertical,
            ),
          );
        });
        break;
      case TETRIMINO_NAME.S:
        tetriminoS.forEach((TetriminoCollision element) {
          List<Widget> _listVertical = [];
          int cnt = 0;
          element.collision.forEach((bool value) {
            if (value) rightWidth = cnt;
            _listVertical.add(
              _getTetriminoWidget(name, value),
            );
          });
          cnt++;
          _tetriminoList.add(
            Column(
              children: _listVertical,
            ),
          );
        });
        break;
      case TETRIMINO_NAME.Z:
        tetriminoZ.forEach((TetriminoCollision element) {
          List<Widget> _listVertical = [];
          int cnt = 0;
          element.collision.forEach((bool value) {
            if (value) rightWidth = cnt;
            _listVertical.add(
              _getTetriminoWidget(name, value),
            );
          });
          cnt++;
          _tetriminoList.add(
            Column(
              children: _listVertical,
            ),
          );
        });
        break;
      case TETRIMINO_NAME.J:
        tetriminoJ.forEach((TetriminoCollision element) {
          List<Widget> _listVertical = [];
          int cnt = 0;
          element.collision.forEach((bool value) {
            if (value) rightWidth = cnt;
            _listVertical.add(
              _getTetriminoWidget(name, value),
            );
          });
          cnt++;
          _tetriminoList.add(
            Column(
              children: _listVertical,
            ),
          );
        });
        break;
      case TETRIMINO_NAME.L:
        tetriminoL.forEach((TetriminoCollision element) {
          List<Widget> _listVertical = [];
          int cnt = 0;
          element.collision.forEach((bool value) {
            if (value) rightWidth = cnt;
            _listVertical.add(
              _getTetriminoWidget(name, value),
            );
          });
          cnt++;
          _tetriminoList.add(
            Column(
              children: _listVertical,
            ),
          );
        });
        break;
      case TETRIMINO_NAME.O:
        tetriminoO.forEach((TetriminoCollision element) {
          List<Widget> _listVertical = [];
          int cnt = 0;
          element.collision.forEach((bool value) {
            if (value) rightWidth = cnt;
            _listVertical.add(
              _getTetriminoWidget(name, value),
            );
          });
          cnt++;
          _tetriminoList.add(
            Column(
              children: _listVertical,
            ),
          );
        });
        break;
    }

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
        children: <Widget>[
          Container(
            height: height * 30.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.transparent),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
            widget.initHorizontalPosition, widget.initVerticalPosition),
      ),
    );
  }
}
