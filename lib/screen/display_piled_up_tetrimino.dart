import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetoris/model/piled_tetrimino.dart';

class DisplayPiledUpTetrimino extends StatelessWidget {
  final List<List<PiledTetrimino>> piledUpTetrimino;

  DisplayPiledUpTetrimino({
    @required this.piledUpTetrimino,
  });

  Container _getTetriminoWidget(bool collision, Color widgetColor) {
    if (collision) {
      return Container(
        width: 30,
        height: 30,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: widgetColor,
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

  List<Widget> _getWidget() {
    List<Row> columnItem = [];
    piledUpTetrimino.forEach((List<PiledTetrimino> element) {
      List<Widget> rowItem = [];
      element.forEach((PiledTetrimino value) {
        rowItem.add(_getTetriminoWidget(value.collision, value.tetriminoColors));
      });
      columnItem.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: rowItem,
        ),
      );
    });
    return columnItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _getWidget(),
    );
  }
}
