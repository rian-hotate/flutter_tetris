import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tetoris/model/base_tetrimino.dart';
import 'package:flutter_tetoris/model/piled_tetrimino.dart';
import 'package:flutter_tetoris/screen/display_piled_up_tetrimino.dart';
import 'package:flutter_tetoris/screen/display_tetrimino.dart';
import 'package:flutter_tetoris/screen/game_screen.dart';
import 'package:flutter_tetoris/util/tetrimino.dart';

import 'display_next_tetrimino.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool start = false;

  void reset() {
    setState(() {
      start = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: start
          ? GameScreen(
              resetCallBack: reset,
            )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "TETRIS",
                              style: TextStyle(
                                  fontSize: 100, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              "   made only with Flutter",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 100,
                          child: RaisedButton(
                            color: Colors.blue,
                            child: Text("START"),
                            onPressed: () {
                              setState(() {
                                start = true;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
