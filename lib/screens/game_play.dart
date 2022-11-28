import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:lompat_karet_game/widgets/game_over_menu.dart';
import 'package:lompat_karet_game/widgets/game_win_menu.dart';
import '../game/game.dart';
import '../widgets/progress_bar.dart';

class GamePlay extends StatefulWidget {
  final int difficulty;

  const GamePlay(
    this.difficulty, {
    Key? key,
  }) : super(key: key);

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  LompatKaretGame? _lompatKaretGame;

  double _currentValue = 0;
  late double _finalValue = 0;

  late Timer _timer;

  bool zero = true;

  double margin = 0;

  setEndPressed(double value) {
    setState(() {
      _currentValue = value;
    });
  }

  setStart() {
    const oneSec = Duration(milliseconds: 5);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (zero == true) {
        setState(() {
          _currentValue++;
          if (_currentValue == 100) {
            zero = false;
          }
        });
      } else if (zero == false) {
        setState(() {
          _currentValue--;
          if (_currentValue == 0) {
            zero = true;
          }
        });
      }

      if (widget.difficulty == 1) {
        margin = 125;
      } else if (widget.difficulty == 2) {
        margin = 150;
      } else if (widget.difficulty == 3) {
        margin = 175;
      }
    });
  }

  setStop() {
    _timer.cancel();
    print(_currentValue);
    _finalValue = _currentValue;
    setState(() {
      _lompatKaretGame = LompatKaretGame(widget.difficulty, _finalValue);
    });
  }

  @override
  void initState() {
    _lompatKaretGame = LompatKaretGame(widget.difficulty, 0);
    setStart();
    super.initState();
  }

  Widget buildFloatingButton(String text, VoidCallback callback) {
    TextStyle roundTextStyle =
        const TextStyle(fontSize: 16.0, color: Colors.white);
    return FloatingActionButton(
      heroTag: Text(text),
      child: Text(text, style: roundTextStyle),
      onPressed: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/rumahgadang.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: WillPopScope(
            onWillPop: () async => false,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 450,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Row(
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  FAProgressBar(
                                    size: 40,
                                    progressColor: Colors.black54,
                                    backgroundColor: Colors.white,
                                    currentValue: _currentValue,
                                    animatedDuration:
                                        const Duration(milliseconds: 0),
                                    direction: Axis.vertical,
                                    verticalDirection: VerticalDirection.up,
                                    displayText: '%',
                                  ),
                                  Container(
                                    width: 50,
                                    margin: EdgeInsets.symmetric(
                                        vertical: widget.difficulty == 1
                                            ? 125
                                            : widget.difficulty == 2
                                                ? 150
                                                : 175),
                                    // padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blueAccent,
                                            width: 5)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(bottom: 30, right: 30),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: <Widget>[
                      //         buildFloatingButton("start", () => setStart()),
                      //         buildFloatingButton("stop", () => setStop()),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                GameWidget(
                  game: _lompatKaretGame!,
                  initialActiveOverlays: const [],
                  overlayBuilderMap: {
                    ProgressBar.ID:
                        (BuildContext context, LompatKaretGame gameRef) =>
                            ProgressBar(),
                    GameOverMenu.ID:
                        (BuildContext context, LompatKaretGame gameRef) =>
                            GameOverMenu(gameRef),
                    GameWinMenu.ID:
                        (BuildContext context, LompatKaretGame gameRef) =>
                            GameWinMenu(gameRef),
                  },
                ),
                Positioned(
                  bottom: 30,
                  right: 30,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        // buildFloatingButton("start", () => setStart()),
                        buildFloatingButton("stop", () => setStop()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
